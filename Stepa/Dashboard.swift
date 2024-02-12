import SwiftUI

struct Dashboard: View {
    let currentSteps = 8390
    let targetSteps = 10000
    let stepsCount = 4390
    let totalDistance = "18 kms"
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button(action: {
                        // Action for burger menu
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                    
                    Spacer()
                    
                    // Home Button
                    Text("Home")
                        .font(.title) // Making the home text bigger
                    
                    Spacer()
                    
                    // Bell Icon
                    Button(action: {
                        // Action for bell icon
                    }) {
                        Image("Bell")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30) // Making the bell icon bigger
                    }
                }
                .padding()
                
                HStack {
                    Text("Hi Jessica Claire")
                        .foregroundColor(.gray) // Making the text gray
                    
                    Text("Welcome Back!")
                        .font(.title)
                    Spacer ()
                }
                
                HStack {
                    Text("Today's Summary")
                    
                    Spacer()
                    
                    Button(action: {
                        // Action for analysis button
                    }) {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1) // Grey border with a width of 1
                            .frame(width:120)
                            .frame(height:40)
                            .overlay(
                                Text("Analysis")
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                            )
                    }

                }
                
                // Purple Container with Text
                ZStack {
                    Color.purple
                        //.frame(height: geometry.size.height * 0.32) // Adjust the multiplier as needed
                        .frame( height: 230)
                        .cornerRadius(10) // Add corner radius
                        .frame(maxWidth: .infinity)
                    
                    VStack (spacing:10){
                        HStack (spacing:10){
                            Text("\(currentSteps)")
                                .font(.largeTitle) // Larger font size than .title
                                .foregroundColor(.white)
                                .bold()
                                .padding(.top, 15) // Add padding to the top

                            
                            Text("steps") // Label "steps"
                                .font(.subheadline) // Smaller font size for the label
                                .foregroundColor(.white)
                                .padding(.top, 15) // Add padding to the top

                        }
                        .padding()
                        CylinderLoadingBar(progress: calculateProgress()) // Adjust the progress value as needed
                        HStack{
                            Text("0")
                                .foregroundColor(.white)
                            Spacer()
                            Text("target \(targetSteps) steps ")
                                .foregroundColor(.white)

                        }

                        
                        
                        
                        HStack {
                            // Total Distance Container
                            ZStack {
                                RoundedRectangle(cornerRadius: 10) // Rounded rectangle shape
                                    .stroke(Color.white, lineWidth: 1) // White border
                                    .frame(height: 60) // Adjust height as needed
                                    .padding() // Add padding
                                
                                HStack {
                                    // Icon
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 20) // RoundedRectangle for background color
                                            .fill(Color.white) // White background inside the border
                                            .frame( height: 50)
                                            .frame(width: 50)
                                            
                                        
                                        Image(systemName: "flame.fill") // Example icon, replace with your desired icon
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30) // Adjust icon size
                                            .padding(8) // Add padding to contain the border
                                            .foregroundColor(Color(hex: "#76329C")) // Set icon color to white

                                    }

                                    // Title and distance
                                    VStack(alignment: .trailing, spacing: 0) { // Set spacing to 0
                                        Text("Total Distance")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                        
                                        Text("18 km")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            Spacer() // Add space between the two containers
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10) // Rounded rectangle shape
                                    .stroke(Color.white, lineWidth: 1) // White border
                                    .frame(height: 60) // Adjust height as needed
                                    .padding() // Add padding
                                
                                HStack {
                                    // Icon
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 20) // RoundedRectangle for background color
                                            .fill(Color.white) // White background inside the border
                                            .frame( height: 50)
                                            .frame(width: 50)
                                            
                                        
                                        Image(systemName: "flame.fill") // Example icon, replace with your desired icon
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30) // Adjust icon size
                                            .padding(8) // Add padding to contain the border
                                            .foregroundColor(Color(hex: "#76329C")) // Set icon color to white

                                    }

                                    // Title and distance
                                    VStack(alignment: .trailing, spacing: 0) { // Set spacing to 0
                                        Text("Calories Burned ")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                        
                                        Text("36  cal")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                }
                            }

                        }
                      
                            
                        
                        
               
                        
                        
                        
                        
                    }
                   
                }
             Text("Summary Progress ")
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 20) // RoundedRectangle for background color
                        .stroke(Color(hex: "#76329C"),lineWidth: 1) // White background inside the border
                        //.frame( height: 50)
                        .frame(height: geometry.size.height * 0.2)
                        .frame(width: geometry.size.width * 0.9) // Adjust the multiplier as needed
                    
                    
                    HStack (spacing:){
                    Text("Hi Jessica Claire")
                        .foregroundColor(.gray) // Making the text gray
                        
                    
                    Text("Welcome Back!")
                        .font(.title)
                }
                    

                }
                
                
            }
        }
    }
    func calculateProgress() -> Double {
           return Double(currentSteps) / Double(targetSteps)
       }
}


struct CylinderLoadingBar: View {
    let progress: Double
    
    var body: some View {
        ZStack(alignment: .leading) { // Align content to the leading edge
            Color.gray.opacity(0.2)
                .frame(height: 15)
                .cornerRadius(5)
            
            Capsule()
                .fill(Color.blue)
                .frame(width: CGFloat(progress) * UIScreen.main.bounds.width, height: 15)
                .animation(.linear(duration: 0.5)) // Add animation for smooth transition
        }
    }
}


struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
