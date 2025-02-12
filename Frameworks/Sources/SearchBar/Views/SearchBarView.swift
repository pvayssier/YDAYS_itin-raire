//
//  SearchBarView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 18/12/2024.
//

import SwiftUI
import MapKit
import Combine
import Foundation

// MARK: - Classe pour gérer la recherche d'adresses
class SearchBarManager: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 44.8378, longitude: -0.5792), // Bordeaux
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @Published var searchQuery = "" {
        didSet {
            debounceSearch()
        }
    }
    
    @Published var suggestions: [MKLocalSearchCompletion] = []
    
    private let geocoder = CLGeocoder()
    private var debounceTimer: AnyCancellable?
    private let searchCompleter = MKLocalSearchCompleter()
    
    override init() {
        super.init()
        
        // Définir le délégué du searchCompleter
        searchCompleter.delegate = self
        searchCompleter.resultTypes = [.address] // Limiter aux adresses
    }
    
    // Gère le debounce pour éviter les appels multiples lors de la saisie rapide
    func debounceSearch() {
        
        debugPrint("Recherche en cours pour: \(searchQuery)")
        // Annuler les recherches précédentes
        debounceTimer?.cancel()
        
        // Lancer la recherche après 0.5 secondes si aucune nouvelle frappe n'est détectée
        debounceTimer = Just(searchQuery)
            .delay(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateSuggestions()
            }
    }
    
    // Met à jour les suggestions en fonction du texte de recherche
    private func updateSuggestions() {
            guard !searchQuery.isEmpty else {
                suggestions = [] // Si l'entrée est vide, effacer les suggestions
                return
            }
        debugPrint(searchCompleter.queryFragment)
            searchCompleter.queryFragment = searchQuery
        }
    
    // Effectue une recherche avec la suggestion sélectionnée
    func searchAddress(for suggestion: MKLocalSearchCompletion) {
            let searchRequest = MKLocalSearch.Request(completion: suggestion)
            let localSearch = MKLocalSearch(request: searchRequest)
            
            localSearch.start { [weak self] (response, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Erreur lors de la recherche d'adresse : \(error.localizedDescription)")
                    return
                }
                
                // Centrer la carte sur la première adresse trouvée
                if let mapItem = response?.mapItems.first {
                    DispatchQueue.main.async {
                        self.region.center = mapItem.placemark.coordinate
                    }
                }
            }
        
    }
    
    // MARK: - MKLocalSearchCompleterDelegate
    
    // Cette méthode est appelée lorsqu'il y a des résultats de complétion
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.suggestions = completer.results
        }
    }
        
        // Gestion des erreurs du compléteur
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Erreur dans le searchCompleter : \(error.localizedDescription)")
    }
}
// MARK: - Vue principale
public struct SearchBarView: View {
    @StateObject private var searchBarManager = SearchBarManager()
    @State private var isExpanded = false
    
    public init() {}
    
    public var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Rechercher une adresse...", text: $searchBarManager.searchQuery)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.vertical, 8)
                
                if !searchBarManager.searchQuery.isEmpty {
                    Button(action: {
                        searchBarManager.searchQuery = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.systemGray6))
            )
            .padding(.vertical, 4)
        }
        .padding(.horizontal, 8)
        
        if !searchBarManager.suggestions.isEmpty {
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(searchBarManager.suggestions, id: \.self) { suggestion in
                        Button(action: {
                            searchBarManager.searchAddress(for: suggestion)
                        }) {
                            HStack {
                                Text(suggestion.title)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Text(suggestion.subtitle)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(UIColor.systemGray5))
                            )
                        }
                    }
                }
                .padding(.horizontal, 8)
            }
            .frame(maxHeight: 200)
        }
    
    }
    

}

// MARK: - Preview
struct MapSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}



