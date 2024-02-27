import SwiftUI

struct RegistrationView: View {
    @State private var fullName = ""
    @State private var phoneNumberss = ""
    @State private var emailAddress = ""
    @State private var agreedToTerms = false
    @State private var isDeviceVerificationActive = false
    
    @ObservedObject var viewModel = RegistrationDetailsViewModel()
    @StateObject var userData = UserRegistrationData()


    var body: some View {
        NavigationView{
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
                    
                    // Phone number input field
                    ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color.gray.opacity(0.2))
                                    .frame(height: 50) // Adjust height as needed
                                    .padding()
                                    .frame(width: 360) // Adjust for padding

                                
                                HStack(spacing: 10) {
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
                                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 0)) // Adjust padding as needed
                                }
                                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)) // Adjust padding as needed
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
                    setData() // Update the view model with entered information
                    
                    if agreedToTerms {
                        // Proceed with navigation only if terms are agreed
                        self.isDeviceVerificationActive = true
                    } else {
                        // Handle case where terms are not agreed
                        // You can show an alert or some other UI indicating that terms need to be agreed
                    }                }) {
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
                .disabled(!agreedToTerms) // Disable the NavigationLink if terms are not agreed
                
                HStack{
                NavigationLink(destination: Login()) {
                             Text("Already a member? Login")
                                 .font(.subheadline)
                                 .foregroundColor(.blue)
                                 .multilineTextAlignment(.trailing)
                         }
                }
            }
        }
    }
        .navigationBarHidden(true)
}
    func setData() {
        // Update the view model with entered information
        print("this is meant to be the fullname",fullName)
        self.userData.phoneNumber = self.phoneNumberss
        self.userData.emailAddress = self.emailAddress
        self.userData.agreedToTerms = self.agreedToTerms
        print("this is meant to be the from the getter ", viewModel.registrationDetails.fullName )

        
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


struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
