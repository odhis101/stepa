import SwiftUI

struct EnterPin: View {
    @ObservedObject var viewModel = RegistrationDetailsViewModel()

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
                SecureField("Enter PIN", text: $viewModel.registrationDetails.pin)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                // Confirm PIN
                SecureField("Confirm PIN", text: $viewModel.registrationDetails.confirmPin)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Continue Button
            Button(action: {
                // Handle submit action
            }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#00ADE8"))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .padding(.top, 20)
            .padding(.bottom, 30)
        }
        .onAppear {
        print("This is the logged email address:", viewModel.registrationDetails.emailAddress)
    }
    }
      
}

struct EnterPin_Previews: PreviewProvider {
    static var previews: some View {
        EnterPin()
    }
}
