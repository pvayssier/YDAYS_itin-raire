import SwiftUI
import Resources

public struct ProfileView: View {
    @State private var isEditing: Bool = false
    @State private var name: String = "FUCKING UNICORN"
    @State private var email: String = "PetitPoney@gmail.com"
    @State private var handicap: String = "Visuel"
    

    @State private var showConfirmationAlert: Bool = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Color(UIColor(red: 1.0, green: 0.97, blue: 0.94, alpha: 1.0))
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    Circle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 400, height: 300)
                        .offset(x: -100, y: -400)
                )
            
            VStack(spacing: 20) {
                Image("user_profile", bundle: .main)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 5)
                    .offset(y: -0)
                VStack(spacing: 20) {
                    Text(name)
                        .font(.title3)
                        .foregroundColor(.black)
                }
                
                Spacer().frame(height: 30)
                VStack(spacing: 10) {
                    nameBlock(icon: "person.fill", text: $name, isEditing: $isEditing)
                    emailBlock(icon: "envelope.fill", text: $email, isEditing: $isEditing)
                    HandicapBlock(selectedHandicap: $handicap, isEditing: $isEditing)
                }
                .padding(.horizontal, 30)
                
                Button(action: {
                    showConfirmationAlert = true
                }) {
                    Text(isEditing ? "Valider" : "Modifier")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 150)
                        .background(isEditing ? Color(hex: "#A8E6CF"): Color(hex: "#003366"))
                        .cornerRadius(30)
                        .shadow(radius: 2)
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, -40)
        }
        .alert(isPresented: $showConfirmationAlert) {
            Alert(
                title: Text("Confirmer la modification"),
                message: Text("Souhaitez-vous valider les modifications ?"),
                primaryButton: .destructive(Text("Valider")) {
                    isEditing.toggle()
                },
                secondaryButton: .cancel {
                    
                    showConfirmationAlert = false
                }
            )
        }
    }
}

struct nameBlock: View {
    var icon: String
    @Binding var text: String
    @Binding var isEditing: Bool
    
    init(icon: String, text: Binding<String>, isEditing: Binding<Bool>) {
        self.icon = icon
        self._text = text
        self._isEditing = isEditing
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Nom & Prénom")
                .font(.headline)
                .foregroundColor(.black)
            
            HStack {
                if isEditing {
                    TextField("", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    Text(text)
                        .foregroundColor(.black)
                }
                Spacer()
                Button(action: {
                    isEditing.toggle()
                }) {
                    Image(systemName: isEditing ? "checkmark" : "pencil")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .frame(height: 50)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
    }
}

struct emailBlock: View {
    var icon: String
    @Binding var text: String
    @Binding var isEditing: Bool
    @State private var isValidEmail: Bool = true
    
    init(icon: String, text: Binding<String>, isEditing: Binding<Bool>) {
        self.icon = icon
        self._text = text
        self._isEditing = isEditing
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Email")
                .font(.headline)
                .foregroundColor(.black)
            
            HStack {
                if isEditing {
                    TextField("Entrez votre email", text: $text, onEditingChanged: { _ in
                        validateEmail()
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                } else {
                    Text(text)
                        .foregroundColor(isValidEmail ? .black : .red)
                }
                Spacer()
                Button(action: {
                    if isEditing {
                        validateEmail()
                        if isValidEmail {
                            isEditing.toggle()
                        }
                    } else {
                        isEditing.toggle()
                    }
                }) {
                    Image(systemName: isEditing ? "checkmark" : "pencil")
                        .foregroundColor(isEditing && !isValidEmail ? .red : .gray)
                }
                .disabled(isEditing && !isValidEmail)
            }
            .padding()
            .frame(height: 50)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            
            if isEditing && !isValidEmail {
                Text("Adresse email invalide")
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
    
    private func validateEmail() {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        isValidEmail = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: text)
    }
}

struct HandicapBlock: View {
    @Binding var selectedHandicap: String
    let options = ["Visuel", "Moteur", "Autre"]
    @Binding var isEditing: Bool
    
    init(selectedHandicap: Binding<String>, isEditing: Binding<Bool>) {
        self._selectedHandicap = selectedHandicap
        self._isEditing = isEditing
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Handicap")
                .font(.headline)
                .foregroundColor(.black)
            
            HStack {
                if isEditing {
                    Picker("Handicap", selection: $selectedHandicap) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                } else {
                    Text(selectedHandicap)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding()
            .frame(height: 50)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
    }
}
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        
        // Ignore le caractère '#' si présent
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(hex.startIndex, offsetBy: 1)
        }
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
#Preview {
    ProfileView()
}
