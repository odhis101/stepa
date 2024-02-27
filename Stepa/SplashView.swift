import SwiftUI
/*
 splash view screen 
 */
struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image("Stepa")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.3)
                        
                        
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    isActive = true
                                }
                            }
                         
                        Spacer()
                    }
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
                .background(
                    NavigationLink(
                        destination: OnBoarding(),
                        isActive: $isActive,
                        label: { EmptyView() }
                    )
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
