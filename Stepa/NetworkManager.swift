import Foundation

enum NetworkManagerError: Error {
    case unauthorized
}

class NetworkManager: ObservableObject {
    @Published var response: HTTPURLResponse?
    private let baseURL: String = Constants.baseURL

    
    // Function to send verification request
    func sendVerificationRequest(verificationCodes: [String]) {
        // Encode the verification codes into JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: verificationCodes) else {
            return
        }
        
        // Construct the full URL for the verification endpoint
        guard let url = URL(string: "\(baseURL)/verification") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            DispatchQueue.main.async {
                self.response = httpResponse
            }
        }.resume()
    }
    
    // Function to register a user
    func RegisterEndpoint(fullName: String, phoneNumber: String, emailAddress: String, pin: String, confirmPin: String, agreedToTerms: Bool, completion: @escaping (Bool) -> Void) {
        // Construct the full URL for the register endpoint
        guard let url = URL(string: "\(baseURL)/register") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestData: [String: Any] = [
            "fullName": fullName,
            "phoneNumber": phoneNumber,
            "emailAddress": emailAddress,
            "pin": pin,
            "confirmPin": confirmPin,
            "agreedToTerms": agreedToTerms
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData) else {
            completion(false)
            return
        }
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
        
        task.resume()
    }
    
    // Function to handle user login
    func login(phoneNumber: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else {
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
                    completion(.success(()))
                case 401:
                    completion(.failure(NetworkManagerError.unauthorized))
                default:
                    completion(.failure(NSError(domain: "Unknown error", code: httpResponse.statusCode, userInfo: nil)))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}
