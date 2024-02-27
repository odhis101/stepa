import SwiftUI

import UIKit

struct EnterPin: View {
    @ObservedObject var viewModel = RegistrationDetailsViewModel()
    @State private var isPostRequestSent = false // Track if the POST request has been sent
    @State private var isNavigatingToDashboard = false // Track navigation to Dashboard page
    @State private var firstPin = "" // Track navigation to Dashboard page
    @State private var SecondPin = ""
    @ObservedObject var userData = UserRegistrationData ()
    @State private var isLoading: Bool = false // Track loading state

    var body: some View {
        VStack {
            // Title
            Text("Enter Pin")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, -50)
            
            // Description
            Text("Please create your pin to continue")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 5)
                .padding(.horizontal)
                .multilineTextAlignment(.leading)

            
            // Input fields
            VStack(spacing: 20) {
                // PIN
                SecureField("Enter PIN", text: $firstPin)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                // Confirm PIN
                SecureField("Confirm PIN", text: $SecondPin)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Continue Button
            Button(action: {
                isLoading = true // Set loading state to true
                setData()
            }) {
                if isLoading {
                    // Show loader if isLoading is true
                    ProgressView()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#00ADE8"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                } else {
                    // Show submit button if isLoading is false
                    Text("Submit")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#00ADE8"))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 30)
        }
        .onAppear {
            // this is good logic we need to get the data before logging in
            print("This is the logged email address:", viewModel.registrationDetails.emailAddress)
        }
        .background(
            NavigationLink(
                destination: Dashboard(), // Destination page to navigate
                isActive: $isNavigatingToDashboard, // Binding to control navigation
                label: { EmptyView() }
            )
            .hidden()
        )
    }

    func setData() {
        let fullName = userData.fullName
        let phoneNumber = userData.phoneNumber
        let emailAddress = userData.emailAddress
        let pin = firstPin
        let confirmPin = SecondPin
        let agreedToTerms = true

        let networkManager = NetworkManager()
        networkManager.RegisterEndpoint(fullName: fullName, phoneNumber: phoneNumber, emailAddress: emailAddress, pin: pin, confirmPin: confirmPin, agreedToTerms: agreedToTerms) { success in
            if success {
                isPostRequestSent = true
                isNavigatingToDashboard = true
            } else {
                print("something went wrong ....")
            }
            isLoading = false // Set loading state to false after request completes
        }
    }
}
           
