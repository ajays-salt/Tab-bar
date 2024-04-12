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

struct SoftwaresResponse: Codable {
    let softwares: String
}


struct Employment: Codable {
    let companyName: String
    let yearsOfExperience: String
    let employmentDesignation: String
    let employmentPeriod: String
    let employmentType: String

    enum CodingKeys: String, CodingKey {
        case companyName = "Company Name"
        case yearsOfExperience = "Years of Experience"
        case employmentDesignation = "Employment Designation"
        case employmentPeriod = "Employment Period"
        case employmentType
    }
}

// Assuming there is an array of experience
struct ExperienceList: Decodable {
    let experience: [Employment]
}
