//
//  Model.swift
//  olousTabBar
//
//  Created by Salt Technologies on 15/03/24.
//

import Foundation
import UIKit

extension UITextView {
    func addDoneButtonOnKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonTapped() {
        self.resignFirstResponder()
    }
}

struct SoftwaresResponse: Codable {
    let softwares: String
}

struct UserProfileUpdate: Codable {
    let hobbies: String
    let preferredWorkType: String
    let willingToRelocate: String
    let gender: String
    let noticePeriod: String
    let currentlyEmployed: String
    let permanentAddress: String
    let currentAddress: Address
    let currentCtc: Double
    let expectedCtc: Double
    let language: [Language]
    let portfolio: String
}

struct UserPersonalInfo: Codable {
    var name: String
    var panNo: String // "Pan no" in the JavaScript code
    var dateOfBirth: String
    var nationality: String
    var passportNo: String
    var uidNumber: String
    var permanentAddress: String
    var gender: String
    var profilePicData: Data? // For the resume/profilePic
}

struct Address: Codable {
    let address: String
    let state: String?
    let city: String?
    let pincode: String
}

struct UserPreferencesUpdate: Codable {
    let hobbies: String
    let preferredWorkType: String
    let willingToRelocate: String
    let noticePeriod: String
    let currentlyEmployed: String
    let currentCtc: Double
    let expectedCtc: Double
    let portfolio: String
}


struct Education: Codable {
    let educationName: String?
    let yearOfPassing: String?
    let boardOrUniversity: String?
    let marksObtained: String?

    enum CodingKeys: String, CodingKey {
        case educationName = "Education Name"
        case yearOfPassing = "Year of Passing"
        case boardOrUniversity = "Board/University"
        case marksObtained = "Marks Obtained"
    }
}

struct Employment: Codable {
    let companyName: String
    let yearsOfExperience: String
    let employmentDesignation: String
    let employmentPeriod: String
    let employmentType: String?

    enum CodingKeys: String, CodingKey {
        case companyName = "Company Name"
        case yearsOfExperience = "Years of Experience"
        case employmentDesignation = "Employment Designation"
        case employmentPeriod = "Employment Period"
        case employmentType
    }
}

struct Language: Codable {
    let language: String
    let fluencyLevel: String?
    let read: Bool?
    let write: Bool?
    let speak: Bool?
    
    enum CodingKeys: String, CodingKey {
        case language
        case fluencyLevel = "fluencyLevel"
        case read
        case write
        case speak
    }
}

struct User: Codable {
    var _id: String
    var email: String?
    var name: String?
    var password: String?
    var role: String?
    var city: String?
    var state: String?
    var designation: String?
    var profilePic: String?
    var resume: String?
    var education: [Education]?
    var experience: [Employment]?
    var softwares: [String]?
    var projects: [Project]?
    var skills: [String]?
    var additionalCertificates: [String]?
    var currentCtc: String?
    var expectedCtc: String?
    var noticePeriod: String?
    var gender: String?
    var willingToRelocate: String?
    var currentlyEmployed: String?
    var preferredWorkType: String?
    var hobbies: String?
    var headline: String?
    var portfolio: String?
    var summary: String?
    var totalExperience: Double?
    var hasCompletedOnboarding: Bool?
    var permanentAddress: String?
    var currentAddress: Address?
    var language: [Language]?
    var emailVerified: Bool?
    var mobile: String?
    var whatsappUpdate: Bool?
    var seenDashboard: Bool?
    var panNo: String?
    var dateOfBirth: String?
    var nationality: String?
    var passportNo: String?
    var uidNumber: String?

    enum CodingKeys: String, CodingKey {
        case _id, email, name, password, role, city, state, designation, profilePic, resume, education, experience, softwares, projects, skills, additionalCertificates, currentCtc, expectedCtc, noticePeriod, gender, willingToRelocate, currentlyEmployed, preferredWorkType, hobbies, headline, portfolio, summary, totalExperience, hasCompletedOnboarding, permanentAddress, currentAddress, language, emailVerified, mobile, whatsappUpdate, seenDashboard, panNo = "Pan no", dateOfBirth, nationality, passportNo, uidNumber
    }
}

struct ProjectsResponse: Codable {
    let softwares: String
}

struct Project: Codable {
    let projectName: String
    let role: String
    let responsibility: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case projectName = "Project Name"
        case role = "Role"
        case responsibility = "Responsibility"
        case description = "Description"
    }
}


struct CompanyResponse: Codable {
    let currentPage: Int
    let totalPages: Int
    let companies: [Company]
}

struct Company: Codable {
    let id: String
    let createdBy: String?
    let description: String?
    let location: String?
    let email: String?
    let field: String?
    let jobCount: Int?
    let logo: String?
    let name: String
    let sector: [String]?
    let size: String?
    let website: String?
    let who: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdBy, description, location, email, field, jobCount, logo, name, sector, size, website, who
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        createdBy = try container.decodeIfPresent(String.self, forKey: .createdBy)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        location = try container.decodeIfPresent(String.self, forKey: .location)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        field = try container.decodeIfPresent(String.self, forKey: .field)
        jobCount = try container.decodeIfPresent(Int.self, forKey: .jobCount)
        logo = try container.decodeIfPresent(String.self, forKey: .logo)
        name = try container.decode(String.self, forKey: .name)
        sector = try container.decodeIfPresent([String].self, forKey: .sector)
        website = try container.decodeIfPresent(String.self, forKey: .website)
        who = try container.decodeIfPresent(String.self, forKey: .who)
        
        // Decode size which might be Int or String
        if let sizeValue = try? container.decodeIfPresent(Int.self, forKey: .size) {
            size = String(sizeValue ?? 0)
        } else if let sizeValue = try? container.decodeIfPresent(String.self, forKey: .size) {
            size = sizeValue
        } else {
            size = nil
        }
    }
}

struct RecJobCompany: Codable {
    let id: String
    let name: String
    let description: String
    let logo: String
    let updatedAt: String
    let createdBy: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case description
        case logo
        case updatedAt
        case createdBy
    }
}


