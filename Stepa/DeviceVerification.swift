import SwiftUI
import Combine

struct DeviceVerification: View {
    @State private var timerValue = 20
    @State private var isResendEnabled = false
    @State private var verificationCodes: [String] = Array(repeating: "", count: 5)
    @State private var isNavigationActive = false // State variable to track navigation
    @FocusState private var focusedTextField: Int? // Track the focused text field index
    
    // Inject the network manager
    @StateObject private var networkManager = NetworkManager()
    
    var body: some View {
        VStack(spacing: 20) {
            // Animation (Replace with your animation view)
            
            // Title
            Text("Device Verification").font(.title)
            
            // Subtitle
            Text("A code has been sent to +254...").font(.subheadline)
            
            // Verification Boxes
            HStack(spacing: 10) {
                ForEach(0..<verificationCodes.count, id: \.self) { index in
                    TextField("0", text: self.$verificationCodes[index])
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .onChange(of: verificationCodes[index]) { value in
                            // Move focus to the next text field when a number is entered
                            if !value.isEmpty && value.count == 1 {
                                if index < verificationCodes.count - 1 {
                                    focusedTextField = index + 1
                                } else {
                                    focusedTextField = nil
                                    // Uncomment the line below to navigate immediately upon entering the last code
                                     isNavigationActive = true
                                }
                            }
                        }
                        .focused($focusedTextField, equals: index) // Track focused text field
                }
            }
            
            // Resend Timer
            Text("Resend in \(timerValue) seconds")
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        if self.timerValue > 0 {
                            self.timerValue -= 1
                        } else {
                            timer.invalidate()
                            self.isResendEnabled = true
                        }
                    }
                }
            
            // Resend Button
            Button(action: {
                // Handle resend action
                self.timerValue = 20
                self.isResendEnabled = false
                self.isNavigationActive = true

                // Send the verification codes to the endpoint again
                //demo purposes only 
                //networkManager.sendVerificationRequest(verificationCodes: verificationCodes)
            }) {
                Text("Resend").foregroundColor(.blue)
            }
            .disabled(!isResendEnabled)
            
            Spacer()
        }
        .padding()
        .onReceive(networkManager.$response) { response in
            // Check if the response is not nil and if its status code is 200
            if let httpResponse = response, httpResponse.statusCode == 200 {
                // Navigate to the next screen upon receiving a successful response
                isNavigationActive = true
            }
        }
        .background(
            NavigationLink(
                destination: EnterPin(), // Destination page to navigate
                isActive: $isNavigationActive, // Binding to control navigation
                label: { EmptyView() }
            )
        )
    }
}


struct DeviceVerification_Previews: PreviewProvider {
    static var previews: some View {
        DeviceVerification()
    }
}
