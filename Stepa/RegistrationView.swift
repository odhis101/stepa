import SwiftUI

struct RegistrationView: View {
    @State private var fullName = ""
    @State private var phoneNumber = ""
    @State private var emailAddress = ""
    @State private var agreedToTerms = false
    @State private var isDeviceVerificationActive = false
    
    @State private var showToast = false // State variable to control toast visibility
    @ObservedObject var viewModel = RegistrationDetailsViewModel()

    var body: some View {
        ZStack {
            // Main content
            VStack {
                // Register Title
                Text("Register")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, -50)
                
                // Description
                Text("Please enter the requested information to register to Stepa mobile app")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                    .padding(.horizontal)
                
                // Input fields
                VStack(spacing: 20) {
                    // Full Name
                    TextField("Full Name", text: $fullName)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                    // Phone Number
                    HStack(spacing: 10) {
                        Image("kenya")
                            .resizable()
                            .frame(width: 30, height: 20)
                        
                        Text("+254")
                        
                        Spacer()
                        
                        TextField("Phone Number", text: $phoneNumber)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                    
                    // Email Address
                    TextField("Email Address", text: $emailAddress)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Terms & Conditions
                HStack {
                    CheckboxFieldView(isChecked: $agreedToTerms)
                        .padding(.trailing, 10)
                    
                    Text("I agree to the terms & conditions")
                    
                    Spacer()
                }
                .padding()
                
                // Continue Button
                Button(action: {
                    
                    //showToast = true // Show toast before navigating
                    self.isDeviceVerificationActive = true
/*
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.isDeviceVerificationActive = true
                    }
 */
                }) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#00ADE8"))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                .padding(.bottom,30)
                
                NavigationLink(
                    destination: DeviceVerification(),
                    isActive: $isDeviceVerificationActive,
                    label: { EmptyView() }
                )
            }
            .blur(radius: showToast ? 5 : 0) // Apply blur effect if showToast is true
            
            // Toast

        }
    }
    func setData(){
        let vdata = RegistrationDetailsViewModel()
        vdata.registrationDetails.FULLNAME = fullName
    }
}

struct CheckboxFieldView: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray, lineWidth: 2)
                    .frame(width: 20, height: 20)
                
                if isChecked {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct ToastView: View {
    let message: String
    let continueAction: () -> Void // Action to perform when continue button is tapped
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        continueAction()
                    }) {
                        Text("Continue")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.black) // Background color of the continue button
                            .cornerRadius(8)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 20)
            
            VStack {
                Text(message)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color(hex: "#00ADE8"))
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20) // Adjust bottom padding for spacing
                    .transition(.move(edge: .bottom))
            }
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.7)) // White background
            .cornerRadius(20)
            .padding(.horizontal, 20)
        }
    }
}


struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
