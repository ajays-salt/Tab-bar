//
//  JobModel.swift
//  olousTabBar
//
//  Created by Salt Technologies on 08/04/24.
//

import Foundation




// being used

struct JobResponse: Codable {
    let jobs: [Job]
    let totalPages: Int
    let currentPage: Int
    let totalJobs: Int
}

struct Job: Codable {
    let id: String
    let version: Int?
    let title: String
    let location: Location?
    let company: Company?
    let status: String
    let preferredQualification: [String]?
    let sectors: [String]
    let keyResponsibilities: [Responsibility]?
    let requirements: [Requirement]
    let createdAt: String?
    let updatedAt: String?
    let workPlace: String?
    let companyName: String?
    let companyLogo: String?
    let jobType: String?
    let maxExperience: String?
    let minExperience: String?
    let noOfPeople: Int?
    let salaryRangeFrom: String?
    let salaryRangeTo: String?
    let whatWeOffer: [String]?
    let jobSummary: String?
    let softwares: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case version = "__v"
        case title
        case location
        case company
        case status
        case preferredQualification
        case sectors
        case keyResponsibilities
        case requirements
        case createdAt
        case updatedAt
        case workPlace
        case companyName
        case companyLogo
        case jobType
        case maxExperience
        case minExperience
        case noOfPeople
        case salaryRangeFrom
        case salaryRangeTo
        case whatWeOffer
        case jobSummary
        case softwares
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        version = try container.decodeIfPresent(Int.self, forKey: .version)
        title = try container.decode(String.self, forKey: .title)
//        location = try container.decodeIfPresent(Location.self, forKey: .location)
//        company = try container.decodeIfPresent(Company.self, forKey: .company)
        status = try container.decode(String.self, forKey: .status)
        preferredQualification = try container.decodeIfPresent([String].self, forKey: .preferredQualification)
        sectors = try container.decode([String].self, forKey: .sectors)
        keyResponsibilities = try container.decodeIfPresent([Responsibility].self, forKey: .keyResponsibilities)
        requirements = try container.decode([Requirement].self, forKey: .requirements)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        workPlace = try container.decodeIfPresent(String.self, forKey: .workPlace)
        companyName = try container.decodeIfPresent(String.self, forKey: .companyName)
        companyLogo = try container.decodeIfPresent(String.self, forKey: .companyLogo)
        jobType = try container.decodeIfPresent(String.self, forKey: .jobType)
        noOfPeople = try container.decodeIfPresent(Int.self, forKey: .noOfPeople)
        whatWeOffer = try container.decodeIfPresent([String].self, forKey: .whatWeOffer)
        jobSummary = try container.decodeIfPresent(String.self, forKey: .jobSummary)
        
        if let locationValue = try? container.decode(Location.self, forKey: .location) {
            location = locationValue
        } else if let _ = try? container.decode(String.self, forKey: .location) {
            location = nil
        } else {
            location = nil
        }
        
        if let companyValue = try? container.decode(Company.self, forKey: .company) {
            company = companyValue
        } else if let _ = try? container.decode(String.self, forKey: .company) {
            company = nil
        } else {
            company = nil
        }
        
        // Decode softwares which might be an array of strings or an array of dictionaries
        var softwareArray = [String]()
        var nestedContainer = try? container.nestedUnkeyedContainer(forKey: .softwares)
        if nestedContainer != nil {
            while !nestedContainer!.isAtEnd {
                if let softwareString = try? nestedContainer!.decode(String.self) {
                    softwareArray.append(softwareString)
                } else if let softwareDict = try? nestedContainer!.decode([String: String].self),
                          let softwareString = softwareDict["name"] {
                    softwareArray.append(softwareString)
                }
            }
        }
        softwares = softwareArray

        // Decode maxExperience which might be Int or String
        if let maxExperienceValue = try? container.decode(Int.self, forKey: .maxExperience) {
            maxExperience = String(maxExperienceValue)
        } else if let maxExperienceValue = try? container.decode(String.self, forKey: .maxExperience) {
            maxExperience = maxExperienceValue
        } else {
            maxExperience = nil
        }

        // Decode minExperience which might be Int or String
        if let minExperienceValue = try? container.decode(Int.self, forKey: .minExperience) {
            minExperience = String(minExperienceValue)
        } else if let minExperienceValue = try? container.decode(String.self, forKey: .minExperience) {
            minExperience = minExperienceValue
        } else {
            minExperience = nil
        }

        // Decode salaryRangeFrom which might be String or Double
        if let salaryRangeFromValue = try? container.decode(Double.self, forKey: .salaryRangeFrom) {
            salaryRangeFrom = String(salaryRangeFromValue)
        } else if let salaryRangeFromValue = try? container.decode(String.self, forKey: .salaryRangeFrom) {
            salaryRangeFrom = salaryRangeFromValue
        } else {
            salaryRangeFrom = nil
        }

        // Decode salaryRangeTo which might be String or Double
        if let salaryRangeToValue = try? container.decode(Double.self, forKey: .salaryRangeTo) {
            salaryRangeTo = String(salaryRangeToValue)
        } else if let salaryRangeToValue = try? container.decode(String.self, forKey: .salaryRangeTo) {
            salaryRangeTo = salaryRangeToValue
        } else {
            salaryRangeTo = nil
        }
    }
}



struct Location: Codable {
    let city: String
    let state: String
    let country: String
}

struct Qualification: Codable {
    let title: String
}

struct Experience: Codable {
    let title: String
}

struct Software: Codable {
    let title: String
}

struct Sector: Codable {
    let title: String
}

struct ProjectExperience: Codable {
    let title: String
}

struct Responsibility: Codable {
    let title: String
    let shortDescription: String
}

struct Requirement: Codable {
    let title: String
    let shortDescription: String
}




struct CompanyJobResponse: Codable {
    let jobs: [Job]
    let company: Company
}



struct Attribute: Codable {
    let mustHave: Int
    let selected: Int
    let title: String
}

struct SavedJobsResponse: Codable {
    let success: Bool
    let savedJobs: SavedJobs
}

struct SavedJobs: Codable {
    let id: String
    let savedJobs: [String]
    let savedBy: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case savedJobs
        case savedBy
        case v = "__v"
    }
}
