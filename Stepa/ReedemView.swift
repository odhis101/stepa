import SwiftUI

struct ReedemView: View {
    let images: [String] = ["poster1", "poster2", "poster3",] // Your image names
    
    let images2: [String] = ["poster1", "poster2", "poster2",] // Your image names
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView(.vertical) {
            VStack{
                HStack{
                VStack(alignment: .leading) {
                    Text("Redeem")
                        .fontWeight(.bold)
                }
                    Spacer()
                }
                .padding(.horizontal,10)


                HStack{
                VStack(alignment: .leading, spacing: 0) { // Set alignment to .leading
                    Text("Summary Progress ")
                        .foregroundColor(Color(hex: "#474041"))
                        
                }
                    Spacer()
                }
                .padding(.horizontal,10)

                HStack{
                Spacer()
                    TotalPointsView(geometry: geometry)
                    Spacer()
                }
                VStack {
                    // Recommended Policy Text
                    HStack {
                        Text("Recommended Policy")
                            .foregroundColor(Color(hex: "#083273"))

                        Spacer()
                    }
                    .padding()

                    imageScrollView(images:images)

                    
                    
                    HStack {
                        Text("Other Policy")
                            .foregroundColor(Color(hex: "#083273"))

                        Spacer()
                    }
                    .padding()

                    imageScrollView(images:images)


                }
            }
        }

    }

}

}

struct ReedemView_Previews: PreviewProvider {
    static var previews: some View {
        ReedemView()
    }
}

func TotalPointsView(geometry: GeometryProxy) -> some View {
    HStack{
        Spacer()
    VStack {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(hex: "#76329C"), lineWidth: 1)
                .frame(height: geometry.size.height * 0.18)
                .frame(width: geometry.size.width * 0.95)

            VStack {
                HStack {
                    Text("Total points:")
                        .foregroundColor(.gray)
                    // this will be a get request
                    Text("10,3990 pts")
                        .bold()
                    
                    Spacer()
                } .padding()

                HStack {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color(hex: "#ECE3F1"))
                        Text("4300 steps")
                            .font(.subheadline)
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color(hex: "#ECE3F1"))

                        Text("34 km")
                            .font(.subheadline)

                    }
                    Spacer()
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color(hex: "#ECE3F1"))

                        Text("340 calories")
                            .font(.subheadline)

                    }
                    Spacer()
                }
                .padding()            }
        }
    }
        Spacer()
}
}
func imageScrollView(images: [String]) -> some View {
    ScrollView(.horizontal) {
        HStack(spacing: 0) {
            ForEach(images, id: \.self) { imageName in
                ZStack {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300) // Adjust size as needed
                        .padding(8)
                        .foregroundColor(Color(hex: "#76329C"))
                    
                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.2), .black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                        .frame(width: 300, height: 300) // Match the size of the image
                        .cornerRadius(10) // Adjust corner radius as needed
                    
                    VStack {
                        Spacer()
                        Text("Your Text Here")
                            .foregroundColor(.white)
                            .padding()
                        
                        Text("Jubilee Health Insurance is levelling up your wellness and fitness journey with the “Do Anything For The Steps Campaign”. Learn more")
                            .foregroundColor(.white)
                            .padding()
                        
                        NavigationLink(destination: Insurance()) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                                .frame(height: 40)
                                .overlay(
                                    Text("Redeem Points")
                                        .foregroundColor(.white)
                                )
                        }

                            .padding()
                    }
                    .frame(width: 300, height: 300) // Match the size of the image
                }
                .padding(5) // Add padding to separate images
            }
        }
    }
}
