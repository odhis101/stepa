import SwiftUI
import HealthKit


struct Dashboard: View {
     let currentSteps  = 1312
    let targetSteps = 10000
    let totalDistance = "0.8 kms"
    let healthStore = HKHealthStore()
    let healthManager = HealthManager()

    //@State private var currentSteps: Int?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
            VStack {
                NavigationBar()
                // greeting bar
                HStack {
                    Text("Hi Jessica Claire")
                        .foregroundColor(.gray) // Making the text gray
                        
                    
                    Text("Welcome Back!")
                        
                    Spacer ()
                }
                .padding(.top,10)

                SummaryHeader ()

                MyPurpleView(currentSteps: currentSteps, targetSteps: targetSteps, calculateProgress: calculateProgress)
                
                HStack() {
                    Text("Summary Progress ")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#474041"))
                    Spacer()
                }
                
                createPointsView(geometry: geometry)
            Spacer()
                HStack( spacing: 5) {
                    Text("Find more ")
                    
                    Spacer()
                    Image("bar")

                }
                .padding(.horizontal,20)
                
                
                createWalkingView()
                .padding() // Add padding to the HStack
                .background(Color.white) // Set background color if needed
                .cornerRadius(20)
                
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("How to manage your steps")
                            .foregroundColor(.black) // Set text color
                            .font(.headline) // Set font size
                        
                        HStack(spacing: 5) {
                            Text("5 reps")
                                .foregroundColor(.black) // Set text color
                            
                            Text("20 second rest")
                                .foregroundColor(.black) // Set text color
                        }
                        .font(.subheadline) // Set font size
                    }
                    .padding(.leading, 10) // Add left padding to align with capsule shape
                    
                    Spacer() // Add spacer to push play button to the right
                    
                    Image(systemName: "play.circle.fill") // Play button
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30) // Adjust size as needed
                        .foregroundColor(.blue) // Set button color
                    
                }
                .padding(10) // Add padding around the content
                
                .background(
                    Capsule()
                        .trim(from: 0.2, to: 1) // Trim the shape to 75% of its original size
                        .stroke(Color.blue, lineWidth: 2) // Blue border
                        .background(
                              Capsule()
                                  .fill(Color(hex: "#E7F4F8")) // Blue fill
                              
                          )                )

                .padding(10)
                

                
            }
            .frame(width: geometry.size.width * 0.95) // Adjust the multiplier as needed
            .padding(geometry.size.width * 0.03)

            }
            
            .navigationBarHidden(true) // Hide the navigation bar


        }
        .navigationBarHidden(true) // Hide the navigation bar

    }
    func calculateProgress() -> Double {
        return Double(currentSteps) / Double(targetSteps)
    }


/*
    private func fetchSteps() {
        print ("we are in dashboard just about to call health manager in the other file ")
        healthManager.fetchStepCount { fetchedStepCount in
            DispatchQueue.main.async {
                self.currentSteps = fetchedStepCount
            }
        }
    }
 
 */

}





func NavigationBar() -> some View {
    HStack {
        Button(action: {
        }) {
            Image(systemName: "line.horizontal.3")
                .foregroundColor(.black) // Change the color to black
                .font(.system(size: 26)) // Make the image bigger by setting the font size to 30
        }
        
        Spacer()
        
        // Home Button
        Text("Home")
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
}

func SummaryHeader() -> some View {
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
                        .foregroundColor(Color(hex: "#9A9294"))
                )
        }
    }
}

struct MyPurpleView: View {
    var currentSteps: Int
    var targetSteps: Int
    var calculateProgress: () -> Double // Function to calculate progress

    var body: some View {
        ZStack {
            Color.white
                .frame(height: 350)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
                .border(Color.gray, width: 0.3) // Add border with black color and 2-point width


            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    Text("\(currentSteps)")
                        .font(.system(size: 24))
                        .bold()
                        .padding(.top, 15)
                        .padding(.leading,10)

                    Text("steps")
                        .font(.subheadline)
                        .padding(.top, 15)
                    
                    Spacer()
                }
                                
                VStack {
       
                    CircularLoadingView(progress: calculateProgress(),currentSteps:currentSteps)
                           .padding(.bottom, 10)
                           .frame( height: 200)
                                    }
                .frame(width: 350)

                HStack {
                    // Total Distance Container
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                            .frame(height: 60)
                            .padding()

                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .frame(height: 40)
                                    .frame(width: 40)

                                Image(systemName: "figure.walk")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(8)
                                    .foregroundColor(Color.blue)
                            }

                            VStack(alignment: .trailing, spacing: 0) {
                                Text("Steps ")
                                    .font(.subheadline)
                                    .foregroundColor(Color.blue)


                                Text("\(currentSteps)")
                                    .font(.headline)
                                    .foregroundColor(Color.purple)

                            }
                            .padding(10)
                        }
                    }
                    Divider()
                        .background(Color.gray)

                    Spacer()

                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                            .frame(height: 60)
                            .padding()

                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .frame(height: 40)
                                    .frame(width: 40)

                                Image(systemName: "flame.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(8)
                                    .foregroundColor(Color.blue)
                            }

                            VStack(alignment: .trailing, spacing: 0) {
                                Text("Calories")
                                    .font(.subheadline)
                                    .foregroundColor(Color.blue)

                                Text("36 cal")
                                    .font(.headline)
                                    .foregroundColor(Color.purple)
                            }
                            .padding(10)
                        }
                    }
                }
            }
        }
    }
}

func createWalkingView() -> some View {
    HStack {
        Image("WalkWithUs")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 10))

        VStack(alignment: .leading, spacing: 5) {
            Capsule()
                .fill(Color(hex: "#E7E6F6"))
                .frame(height: 30)
                .frame(width: 120)
                .foregroundColor(Color(hex: "#E7F4F8"))
            
                .overlay(
                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.red)
                        Text("1860 kcal")
                            .foregroundColor(.black)
                    }
                )

            Text("Walking is good for you")
            Text("ws9566")
                .foregroundColor(Color(hex: "#9A9294"))
        }

        Spacer()
    }
}

func createPointsView(geometry: GeometryProxy) -> some View {
    VStack {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(hex: "#76329C"), lineWidth: 1)
                .frame(height: geometry.size.height * 0.20)
                .frame(width: geometry.size.width * 0.93)
                .foregroundColor(.purple)

            VStack {
                HStack {
                    Text("Total points:")
                        .foregroundColor(.gray)
                    // this will be a get request
                    Text("10,3990 pts")
                        .bold()
                    Spacer()
                }
                .padding(.top,10)
                .padding(.leading,20)

                HStack {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color(hex: "#ECE3F1"))
                            .padding(.leading,5)
                        Text("1312 steps")
                            .font(.subheadline)
                            .padding(.leading,5)

                    }
                    Spacer()
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color(hex: "#ECE3F1"))

                        Text("0.8 km")
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

                NavigationLink(destination: ReedemView()) {
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
        }
    }
}

struct CylinderLoadingBar: View {
    let progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white)
                    .frame(height: 15)
                    .cornerRadius(5)
                    .frame(width:geometry.size.width, height: 15)
                    .animation(.linear(duration: 0.5))


                
                Capsule()
                    .fill(Color.blue)
                    .cornerRadius(5)
                    .frame(width: CGFloat(progress) * geometry.size.width, height: 15)
                    .animation(.linear(duration: 0.5))
            }
        }
    }
}

struct CircularLoadingView: View {
    let progress: Double
    let currentSteps :Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round))
                    .foregroundColor(Color(UIColor.systemGray5)) // Set the empty middle color
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(progress))
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(Angle(degrees: -90.0))
                    .animation(.linear(duration: 0.5))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
               
                VStack(spacing:10){
                    
                    Image(systemName: "figure.walk") // Play button
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40) // Adjust size as needed
                        .foregroundColor(.purple) // Set button color

                    Text("\(Int(currentSteps))")
                        .font(.headline)
                        .font(.system(size: 20))
                        .foregroundColor(.purple) // Set button color


                    
                    Text("steps")
                        .foregroundColor(.purple) // Set button color

                    
                }
                
                
            }
        }
    }
}








struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
