import SwiftUI
/*
 login screen
 */

struct Login: View {

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color.clear // Background color
                    
                    VStack(spacing: 0) {
                        
                    
                        BlueBoxView()
                            .frame(maxWidth: .infinity, maxHeight: geometry.size.height / 2)
            
                        
                        WhiteBoxView()
                            .frame(maxWidth: .infinity, maxHeight: geometry.size.height / 2+10)
                            .alignmentGuide(.top, computeValue: { dimension in
                                -dimension[.bottom] / 2 + 20
                            })
                            .padding(.top, 20) // Add top padding

                    }
                    
                    OverlappingBoxView()
                        .frame(width: geometry.size.width * 0.9, height: 300)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - 15)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
            }
            .navigationBarHidden(true)

        }
        .navigationBarHidden(true)

    }
    
}



struct BlueBoxView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                // Logo or Image
                Image("StepaWhite") // Assuming "Stepa" is the name of your image asset
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.3) // Adjusted height here
                    
                Spacer()
                
                    }
            .frame(maxWidth: .infinity, maxHeight: geometry.size.height) // Use the full height of the BlueBox
            .background(Color(hex: "#00ADE8"))
        }
    }
}

struct WhiteBoxView: View {
    var body: some View {
        VStack {
            Spacer() // Push the VStack to the bottom
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.black)
                    .padding(.trailing, 5) // Adjust padding as needed
                
                Text("Or Connect")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.black)
                    .padding(.leading, 5) // Adjust padding as needed
            }
            .padding(.horizontal, 10) // Adjust padding as needed
            
            HStack(spacing:20) {
                // First icon image
                    Image("apple") // Replace "icon1" with the name of your first icon image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                
                
                    Image("google")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30) // Adjust size as needed
                
                    Image("Samsung")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30) // Adjust size as needed
                
                    Image("Huawei")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height:50) // Adjust size as needed
                    
                
  
            }
        }
    }
}

struct OverlappingBoxView: View {
    @State private var phoneNumberss = ""
    @State private var passwordsss = ""
    @State private var isUnauthorizedModalPresented = false
    @State private var isRegistrationViewPresented = false
    @State private var isActive = false


    //@State private var isActive = false // Activate navigation
    var body: some View {
        VStack() {
            Text("Welcome to ")
                .font(.title)
            +
            Text("Stepa App")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Please provide details")
                .font(.subheadline)
                .multilineTextAlignment(.leading)

            

            ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color.gray.opacity(0.2))
                            .frame(height: 50) // Adjust height as needed
                            .padding()
                            .frame(width: 330) // Adjust for padding

                        
                        HStack(spacing:5) {
                            Image("kenya")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30) // Adjust size as needed
                                .padding(.leading,10)
                            Text("(+254)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            TextField("Phone Number", text: $phoneNumberss)
                                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 0))
                        }
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                    }
     
            SecureField("Password", text: $passwordsss)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            // Forgot Password link
            HStack{
                Spacer()
            Text("Forgot Password")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.trailing)
            }

            
            // Login button
            LoginButton(phoneNumber: $phoneNumberss, password: $passwordsss, isUnauthorizedModalPresented: $isUnauthorizedModalPresented, isActive: $isActive)
    
                        
            HStack{
                
                Text("Not a member? ")
                    .multilineTextAlignment(.trailing)
            NavigationLink(destination: RegistrationView()) {
                         Text("Signup")
                             .font(.subheadline)
                             .multilineTextAlignment(.trailing)
                     }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.bottom, 20) // Add more space below the white box
        .offset(y: -10) // Move the overlapping box slightly higher
        
        
        
    }
}


struct LoginButton: View {
    @Binding var phoneNumber: String
    @Binding var password: String
    @Binding var isUnauthorizedModalPresented: Bool
    @Binding var isActive: Bool // Bind isActive here
    @State private var isLoading: Bool = false // Track loading state
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    let networkManager = NetworkManager() // Create an instance of NetworkManager

    var body: some View {
        Button(action: {
            isLoading = true // Set loading state to true
            networkManager.login(phoneNumber: phoneNumber, password: password) { result in
                switch result {
                case .success:
                    // Navigate to another view on successful login
                    print("Login successful")
                    isActive = true // Activate navigation
                    isLoading = false // Set loading state to false

                case .failure(let error):
                    // Show unauthorized modal on 401 error
                    if case AuthServiceError.unauthorized = error {
                        isUnauthorizedModalPresented = true
                        alertMessage = "Your credentials are wrong"
                        isShowingAlert = true
                    } else {
                        // Handle other errors
                        alertMessage = "Your credentials are wrong"
                        isShowingAlert = true
                        print("Error: \(error)")
                    }
                    isLoading = false // Set loading state to false
                }
            }
        }) {
            if isLoading {
                // Show loader if isLoading is true
                ProgressView()
                    .padding()
                    .background(Color(hex: "#00ADE8"))
                    .foregroundColor(.white)
                    .cornerRadius(5)
            } else {
                // Show login button if isLoading is false
                Text("Login")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#00ADE8"))
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
        }
        .disabled(isLoading) // Disable button while loading
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .background(
            NavigationLink(destination: Dashboard(), isActive: $isActive) {
                EmptyView()
            }
            .hidden()
        )
    }
}

// Networking service for handling login requests
enum AuthServiceError: Error {
    case unauthorized
}

class AuthService {
    static let shared = AuthService()
    
    private init() {}
    
    func login(phoneNumber: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3001/login") else {
            return completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
        }
        
        let parameters: [String: Any] = [
            "password": password,
            "phone_number": phoneNumber
        ]
        
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NSError(domain: "Invalid response", code: -1, userInfo: nil)))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    print("hello this is success")
                    completion(.success(()))
                case 401:
                    completion(.failure(AuthServiceError.unauthorized))
                default:
                    completion(.failure(NSError(domain: "Unknown error", code: httpResponse.statusCode, userInfo: nil)))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
