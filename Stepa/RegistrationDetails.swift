//
//  RegistrationDetails.swift
//  Stepa
//
//  Created by Joshua on 2/8/24.
//

import Foundation

class RegistrationDetails:NSObject,Identifiable {
    var fullName: String?
    var phoneNumber: String = ""
    var emailAddress: String = ""
    var pin: String = "" // New property for password
    var agreedToTerms: Bool = false
    var confirmPin: String = ""
    override init() {
        super.init()
    }
    
    public var FULLNAME:String?{
        get{
            return fullName
        }
        set{
            fullName = newValue
        }
    }
}

