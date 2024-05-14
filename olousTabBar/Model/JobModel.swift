//
//  JobModel.swift
//  olousTabBar
//
//  Created by Salt Technologies on 08/04/24.
//

import Foundation

struct Jobs: Codable {
    let id: String
    let title: String
    let location: Location
    let company: String
    let status: String
    let educationalQualification: [Qualification]
    let experience: [Experience]?
    let softwares: [Software]
    let sectors: [Sector]
    let projectExperience: [ProjectExperience]
    let responsibilities: [Responsibility]
    let requirements: [Requirement]
    let yearsOfExperience: String
    let createdAt: String
    let updatedAt: String
    let workPlace: String?
    let companyName: String //
    let companyLogo: String //

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
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
    }
}


// being used
struct Job: Codable {
    let id: String
    let version: Int?
    let title: String
    let location: Location
    let company: String
    let status: String
    let educationalQualification: [Qualification]
    let experience: [Experience]?
    let softwares: [Software]
    let sectors: [Sector]
    let projectExperience: [ProjectExperience]
    let responsibilities: [Responsibility]
    let requirements: [Requirement]
    let yearsOfExperience: String
    let createdAt: String
    let updatedAt: String
    let workPlace: String?
    let companyName: String?
    let companyLogo: String?
    let jobType: String?
    let maxExperience: String?
    let minExperience: String?
    let noOfPeople: Int?
    let salaryRangeFrom: Double?
    let salaryRangeTo: Double?
    let sessionId: String?

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
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        version = try container.decodeIfPresent(Int.self, forKey: .version)
        title = try container.decode(String.self, forKey: .title)
        location = try container.decode(Location.self, forKey: .location)
        company = try container.decode(String.self, forKey: .company)
        status = try container.decode(String.self, forKey: .status)
        educationalQualification = try container.decode([Qualification].self, forKey: .educationalQualification)
        experience = try container.decodeIfPresent([Experience].self, forKey: .experience)
        softwares = try container.decode([Software].self, forKey: .softwares)
        sectors = try container.decode([Sector].self, forKey: .sectors)
        projectExperience = try container.decode([ProjectExperience].self, forKey: .projectExperience)
        responsibilities = try container.decode([Responsibility].self, forKey: .responsibilities)
        requirements = try container.decode([Requirement].self, forKey: .requirements)
        yearsOfExperience = try container.decode(String.self, forKey: .yearsOfExperience)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        workPlace = try container.decodeIfPresent(String.self, forKey: .workPlace)
        companyName = try container.decodeIfPresent(String.self, forKey: .companyName)
        companyLogo = try container.decodeIfPresent(String.self, forKey: .companyLogo)
        jobType = try container.decodeIfPresent(String.self, forKey: .jobType)
        maxExperience = try container.decodeIfPresent(String.self, forKey: .maxExperience)
        minExperience = try container.decodeIfPresent(String.self, forKey: .minExperience)
        noOfPeople = try container.decodeIfPresent(Int.self, forKey: .noOfPeople)
        salaryRangeFrom = try container.decodeIfPresent(Double.self, forKey: .salaryRangeFrom)
        salaryRangeTo = try container.decodeIfPresent(Double.self, forKey: .salaryRangeTo)
        sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
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

