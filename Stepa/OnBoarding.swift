import SwiftUI

struct OnBoarding: View {
    // Array containing carousel items
    let carouselItems: [(String, [String])] = [
        ("OnBoardingIcon", ["Track", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."]),
        ("OnBoardingIcon2", ["Earn points", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."]),
        ("OnBoardingIcon3", ["Redeem", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."]),
    ]

    @State private var currentIndex = 0
    @State private var isLoginViewActive = false
    @State private var isRegisterViewActive = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        // Logo or Image
                        HStack(alignment: .center) {
                            Image("Stepa")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.3)
                        }
                        
                        // Image Carousel
                        VStack {
                            GeometryReader { carouselGeometry in
                                Image(carouselItems[currentIndex].0)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: carouselGeometry.size.width, height: carouselGeometry.size.height * 1)
                            }
                            .frame(height: geometry.size.height * 0.5)

                            // Carousel Texts
                            ForEach(carouselItems[currentIndex].1.indices, id: \.self) { index in
                                let text = carouselItems[currentIndex].1[index]

                                Text(text)
                                    .font(index == 0 ? .headline : .subheadline)
                                    .foregroundColor(index == 0 ? Color(hex: "#0F297E") : .black)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                        }

                        // Buttons Section
                        VStack(spacing: 16) {
                            NavigationLink(destination: RegistrationView(), isActive: $isRegisterViewActive) {
                                Text("Get Started")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(hex: "#00ADE8"))
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal, 20)

                            // Continue Button
                            NavigationLink(destination: Login(), isActive: $isLoginViewActive) {
                                Button(action: {
                                    // Handle Continue action
                                    self.isLoginViewActive = true
                                }) {
                                    Text("Continue")
                                        .foregroundColor(Color(hex: "#00ADE8"))
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .frame(maxWidth: .infinity)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color(hex: "#00ADE8"), lineWidth: 2)
                                        )
                                }
                                .padding(.horizontal, 20)
                            }
                            .padding(.vertical, 16)
                        }
                    }
                }
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                        withAnimation {
                            currentIndex = (currentIndex + 1) % carouselItems.count
                        }
                    }
                }
                .navigationBarHidden(true)
            }
            .navigationBarHidden(true)

        }
        .navigationBarHidden(true)

    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnBoarding()
        }
    }
}
