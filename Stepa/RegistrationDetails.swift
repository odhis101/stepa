//
//  RegistrationDetails.swift
//  Stepa
//
//  Created by Joshua on 2/8/24.
//

import Foundation

class RegistrationDetails: NSObject, Identifiable {
    // Existing properties
    var fullName: String = ""
    var phoneNumber: String = ""
    var emailAddress: String = ""
    var pin: String = "" // New property for password
    var agreedToTerms: Bool = false
    var confirmPin: String = ""

    // Computed property for fullName
    public var FULLNAME: String {
        get {
            return fullName
        }
        set {
            fullName = newValue
        }
    }

    // Computed property for phoneNumber
    public var PHONENUMBER: String {
        get {
            return phoneNumber
        }
        set {
            phoneNumber = newValue
        }
    }

    // Computed property for emailAddress
    public var EMAILADDRESS: String {
        get {
            return emailAddress
        }
        set {
            emailAddress = newValue
        }
    }

    // Computed property for pin
    public var PIN: String {
        get {
            return pin
        }
        set {
            pin = newValue
        }
    }

    // Computed property for agreedToTerms
    public var AGREEDTOTERMS: Bool {
        get {
            return agreedToTerms
        }
        set {
            agreedToTerms = newValue
        }
    }

    // Computed property for confirmPin
    public var CONFIRMPIN: String {
        get {
            return confirmPin
        }
        set {
            confirmPin = newValue
        }
    }
}

