import SwiftUI

public struct ItinerarySheetView: View {
    @State private var isSheetPresented: Bool = true
    @State private var departure: String = ""
    @State private var arrival: String = ""
    @State private var showRouteBlock: Bool = false // Gère l'affichage du bloc trajet
    @State private var sheetDetent: PresentationDetent = .fraction(0.5) // Taille du Bottom Sheet

    // Vérifie si les deux champs sont remplis
    private var isFormValid: Bool {
        !departure.isEmpty && !arrival.isEmpty
    }

    public init() {}

    public var body: some View {
        VStack {
            Spacer()

            // Bouton flottant au-dessus du sheet
            HStack {
                Spacer()
                Button(action: {
                    // Action du bouton flottant
                }) {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding()
                        .background(Circle().fill(Color.white))
                        .shadow(radius: 10)
                }
                .padding([.top, .trailing], 20)
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            ZStack {
                VStack(spacing: 20) {
                    // Section des boutons "Home", "Travail", "Autre"
                    HStack(spacing: 20) {
                        Button("HOME") {}
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("ContainersColor"))
                            .foregroundColor(Color("TextsColor"))
                            .cornerRadius(30)

                        Button("TRAVAIL") {}
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("ContainersColor"))
                            .foregroundColor(Color("TextsColor"))
                            .cornerRadius(30)

                        Button("AUTRE") {}
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("ContainersColor"))
                            .foregroundColor(Color("TextsColor"))
                            .cornerRadius(30)
                    }

                    // Inputs "Départ" et "Arrivée" avec bouton d'inversion
                    ZStack {
                        VStack(spacing: 15) {
                            TextField("Départ", text: $departure)
                                .padding()
                                .background(Color("InputsColor"))
                                .cornerRadius(20)

                            TextField("Arrivée", text: $arrival)
                                .padding()
                                .background(Color("InputsColor"))
                                .cornerRadius(20)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)

                        Button(action: {
                            swap(&departure, &arrival)
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color("GotoColor"))
                                    .frame(width: 44, height: 44)
                                Image("reverse")
                                    .resizable()
                                    .frame(width: 16, height: 28)
                            }
                        }
                        .offset(x: 140)
                        .buttonStyle(PlainButtonStyle())
                    }

                    // Affichage du bloc trajet après soumission
                    if showRouteBlock {
                        HStack(spacing: 15) {
                            Image(systemName: "car.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color("AccentColor"))

                            Text("Trajet 1")
                                .font(.headline)
                                .foregroundColor(Color("TextsColor"))

                            Spacer()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .transition(.opacity)
                    }

                    // Texte cliquable "Plus de paramètres"
                    Button(action: {}) {
                        HStack {
                            Image("more", bundle: .main)
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text("Plus de paramètres")
                                .foregroundColor(Color("TextsColor"))
                        }
                    }

                    // Bouton de soumission "Allons-y"
                    Button(action: {
                        withAnimation {
                            showRouteBlock = true  // Afficher le bloc trajet
                            sheetDetent = .fraction(0.7) // Agrandir le bottom sheet
                        }
                    }) {
                        Text("ALLONS-Y")
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isFormValid ? Color.accentColor : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .opacity(isFormValid ? 1.0 : 0.6)
                    }
                    .disabled(!isFormValid)
                }
            }
            .padding()
            .presentationDetents([.fraction(0.1), .fraction(0.5), .fraction(0.7)], selection: $sheetDetent)
            .presentationDragIndicator(.visible)
            .onDisappear {
                isSheetPresented = true
            }
        }
    }
}

#Preview {
    ItinerarySheetView()
}
