//
//  Model.swift
//  olousTabBar
//
//  Created by Salt Technologies on 15/03/24.
//

import Foundation

struct EmploymentTemp {
    let companyName: String
    let startYear: Int
    let endYear: Int
    let jobType: String
}
//
struct EducationTemp {
    let collegeName: String
    let startYear: Int
    let endYear: Int
    let courseType: String
}




struct SoftwaresResponse: Codable {
    let softwares: String
}




// Assuming there is an array of experience
struct ExperienceList: Decodable {
    let experience: [Employment]
}



struct UserProfileUpdate: Codable {
    let hobbies: String
    let preferredWorkType: String
    let willingToRelocate: String
    let gender: String
    let noticePeriod: String
    let currentlyEmployed: String
    let permanentAddress: Address
    let currentAddress: Address
    let currentCtc: Double
    let expectedCtc: Double
    let language: [Language]
    let portfolio: String
}



struct Address: Codable {
    let address: String
    let pinCode: String
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
    let proficiencyLevel: String?
    let read: Bool
    let write: Bool
    let speak: Bool
    
    enum CodingKeys: String, CodingKey {
        case language
        case proficiencyLevel = "proficiencyLevel"
        case read
        case write
        case speak
    }
}

struct User: Codable {
    var email: String
    var name: String?
    var password: String?
    var role: String?
    var city: String?
    var state: String?
    var designation: String?
    var profilePic: String?
    var resume: String?
    var education: [Education]? // Consider defining specific struct if structure is known
    var experience: [Employment]? // Consider defining specific struct if structure is known
    var softwares: [String]?
    var projects: [Project]? // Consider defining specific struct if structure is known
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
    var totalExperience: Int?
    var hasCompletedOnboarding: Bool?
    var permanentAddress: Address?
    var currentAddress: Address?
    var language: [Language]?
    var emailVerified: Bool?
    var mobile: String?
    var whatsappUpdate: Bool?
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
