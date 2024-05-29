//
//  JobModel.swift
//  olousTabBar
//
//  Created by Salt Technologies on 08/04/24.
//

import Foundation




// being used
struct Job: Codable {
    let id: String
    let version: Int?
    let title: String
    let location: Location
    let company: RecJobCompany?
    let status: String
    let educationalQualification: [Qualification]
    let experience: [Experience]?
    let softwares: [Software]
    let sectors: [Sector]
    let projectExperience: [ProjectExperience]
    let responsibilities: [Responsibility]
    let requirements: [Requirement]
    let yearsOfExperience: String?
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
    let sessionId: String?
    let showSalaryToCandidate: Bool?
    let salaryRange: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case version = "__v"
        case title
        case location
        case company
        case status
        case educationalQualification
        case experience
        case softwares
        case sectors
        case projectExperience
        case responsibilities
        case requirements
        case yearsOfExperience
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
        case sessionId
        case showSalaryToCandidate
        case salaryRange
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        version = try container.decodeIfPresent(Int.self, forKey: .version)
        title = try container.decode(String.self, forKey: .title)
        location = try container.decode(Location.self, forKey: .location)
        status = try container.decode(String.self, forKey: .status)
        educationalQualification = try container.decode([Qualification].self, forKey: .educationalQualification)
        experience = try container.decodeIfPresent([Experience].self, forKey: .experience)
        softwares = try container.decode([Software].self, forKey: .softwares)
        sectors = try container.decode([Sector].self, forKey: .sectors)
        projectExperience = try container.decode([ProjectExperience].self, forKey: .projectExperience)
        responsibilities = try container.decode([Responsibility].self, forKey: .responsibilities)
        requirements = try container.decode([Requirement].self, forKey: .requirements)
        yearsOfExperience = try container.decodeIfPresent(String.self, forKey: .yearsOfExperience)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        workPlace = try container.decodeIfPresent(String.self, forKey: .workPlace)
        companyName = try container.decodeIfPresent(String.self, forKey: .companyName)
        companyLogo = try container.decodeIfPresent(String.self, forKey: .companyLogo)
        jobType = try container.decodeIfPresent(String.self, forKey: .jobType)
        noOfPeople = try container.decodeIfPresent(Int.self, forKey: .noOfPeople)
        sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
        showSalaryToCandidate = try container.decodeIfPresent(Bool.self, forKey: .showSalaryToCandidate)
        salaryRange = try container.decodeIfPresent(String.self, forKey: .salaryRange)

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

        // Decode company which might be a RecJobCompany or a String
        if let company = try? container.decodeIfPresent(RecJobCompany.self, forKey: .company) {
            self.company = company
        } else if let companyString = try? container.decodeIfPresent(String.self, forKey: .company) {
            self.company = RecJobCompany(id: companyString ?? "", name: companyString ?? "", description: "", logo: "", updatedAt: "")
        } else {
            self.company = nil
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
}

struct Requirement: Codable {
    let title: String
}

struct JobResponse: Codable {
    let jobs: [Job]
    let totalPages: Int
    let currentPage: Int
    let totalJobs: Int
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
