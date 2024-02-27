//
//  Insurance.swift
//  Stepa
//
//  Created by Joshua on 2/15/24.
//

import SwiftUI

struct Insurance: View {
    @State private var fullName = ""
    @State private var showDropdown = false
    @State private var option1Selected = false
    @State private var option2Selected = false
    @State private var phoneNumberss = ""
    @State private var navigateBack = false
    @State private var selectedOption = 0
    @State private var isExpanded = false
    @State private var selectedRadio: Int = 1 // Initialize to default option
    @State private var meSelected: Bool = true
    @State private var someoneElseSelected: Bool = false

    let options = ["Option 1", "Option 2", "Option 3"]

    
    var body: some View {

        
        GeometryReader { geometry in
            ScrollView{
            VStack{
        HStack{
                Text("Jubilee Insurance ")
                    .fontWeight(.bold)
                    Spacer()
            }
        .padding(.horizontal,10)
        .padding(.top,10)
            
            HStack{
            Spacer()
                TotalPointsViewPurple(geometry: geometry)
                Spacer()
                
            }
            .padding(.trailing,10)
            .padding(.bottom,10)
                HStack{
                Spacer()
                    InsuranceIntro(geometry: geometry)
                    Spacer()
                    
                }
                // Full Name
                HStack{
                    Text("Redeem points")
                    Spacer()
                }
                .padding(.horizontal,10)

                VStack{
                TextField("Eg. 10,000 Points", text: $fullName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .frame(width: geometry.size.width * 0.95)
                }
                .padding(.trailing,10)

                // select service provider
                VStack {
                            VStack {
                                HStack{
                                Text("Dropdown")
                                    .font(.headline)
                                    .padding(.bottom, 5)
                                    Spacer()
                                }
                                .padding(.horizontal,10)

                                
                                ZStack {
                                   /*
                                    RoundedRectangle(cornerRadius: 8)
                                                .cornerRadius(8)
                                                .frame(width: geometry.size.width * 0.95)
                                                .background(Color.clear)
                                    
                                    */
                                    
                                            
                                            HStack {
                                                Text(options[selectedOption])
                                                    .padding()
                                                
                                                Spacer()
                                                
                                                Image(systemName: "chevron.down")
                                                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                                                    .foregroundColor(.gray)
                                                    .padding(.horizontal,20)
                                            }
                                        }
                            }
                            .onTapGesture {
                                                    withAnimation {
                                                        isExpanded.toggle()
                                                    }
                            }
                            
                            if isExpanded {
                                VStack {
                                    ForEach(0..<options.count, id: \.self) { index in
                                        Button(action: {
                                            withAnimation {
                                                selectedOption = index
                                                isExpanded.toggle()
                                            }
                                        }) {
                                            Text(options[index])
                                                .foregroundColor(.black)
                                                .padding(.vertical, 8)
                                        }
                                        .background(Color.white)
                                    }
                                }
                                .padding(.vertical, 5)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .animation(.easeInOut)
                            }
                        }
                .padding(.top,10)
                // options myself or phone number
                VStack {
                    HStack {
                        Toggle("Me", isOn: $meSelected)
                            .toggleStyle(RadioButtonStyle(selected: meSelected))
                            .onTapGesture {
                                // Toggle selection
                                meSelected = true
                                someoneElseSelected = false
                            }
                        
                        Spacer()
                        
                        Toggle("Someone Else", isOn: $someoneElseSelected)
                            .toggleStyle(RadioButtonStyle(selected: someoneElseSelected))
                            .onTapGesture {
                                // Toggle selection
                                meSelected = false
                                someoneElseSelected = true
                            }
                    }
                    .padding()
                }
                .padding()
                // Phone number input field
                // Phone number input field
                ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color.gray.opacity(0.2))
                                .frame(height: 60) // Adjust height as needed
                                .padding()
                                .frame(width: 380) // Adjust for padding

                            
                            HStack(spacing: 10) {
                                Image("kenya")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30) // Adjust size as needed
                                    .padding(.leading,20)
                                
                                
                                Text("+254")
                                
                                Spacer()
                                
                                TextField("Phone Number", text: $phoneNumberss)
                                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 0)) // Adjust padding as needed
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)) // Adjust padding as needed
                        }
                Spacer()
                // Continue Button
                Button(action: {
                    self.navigateBack = true
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
                .padding(.bottom,20)
                
                
        }
        }
    }
}
}
struct Insurance_Previews: PreviewProvider {
    static var previews: some View {
        Insurance()
    }
}
func TotalPointsViewPurple(geometry: GeometryProxy) -> some View {
    HStack{
        Spacer()
    VStack {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "#76329C"))
                .frame(height: geometry.size.height * 0.14)
                .frame(width: geometry.size.width * 0.95)

            VStack {
                HStack{
                HStack {
                    Text("Total points: 10,3990 pts")
                        .bold()
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.vertical,10)
                  

                }
                    Spacer()
                    Text("1point = ksh 0.5 ")
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .font(.caption)
                    
                }
                .padding(.horizontal,10)

                HStack {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color.white) // Change color to red

                            
                        Text("4300 steps")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal,10)
                    Spacer()
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color.white) // Change color to red
                        

                        Text("34 km")
                            .foregroundColor(.white)
                            .font(.subheadline)


                    }
                    Spacer()
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color.white) // Change color to red

                        Text("340 calories")
                            .font(.subheadline)
                            .foregroundColor(.white)

                    }
                    Spacer()
                    
                }
                
                
            }
        }
    }
        Spacer()
}
}

func InsuranceIntro(geometry: GeometryProxy) -> some View {
   
    VStack {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "#F7F7F7"))
                .frame(height: geometry.size.height * 0.18)
                .frame(width: geometry.size.width * 0.95)

            VStack {
                HStack{
                    Text("Jubilee Insurance health points")
                        .bold()
                        .padding(.vertical,10)
                    Spacer()
                }
                Text("Health points can be redeemed for items from any of the below. You need to Select redeem mode and continue.")
                    .font(.subheadline)
                
        
            }
        }
    }

}

struct RadioButtonStyle: ToggleStyle {
    var selected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: selected ? "largecircle.fill.circle" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(selected ? .purple : .gray)
            
            configuration.label
        }
    }
}
