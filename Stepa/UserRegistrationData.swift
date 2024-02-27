//
//  UserRegistrationData.swift
//  Stepa
//
//  Created by Joshua on 2/26/24.
//

import Foundation

class UserRegistrationData: ObservableObject {
    @Published var fullName: String = ""
    @Published var phoneNumber: String = ""
    @Published var emailAddress: String = ""
    @Published var agreedToTerms: Bool = false
    
    // You can add more properties as needed
}
