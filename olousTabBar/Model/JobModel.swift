//
//  JobModel.swift
//  olousTabBar
//
//  Created by Salt Technologies on 08/04/24.
//

import Foundation

struct Job: Codable {
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



struct CompanyJobResponse2: Codable {
    let jobs: [Job2]
    let company: Company2
}

struct Company2: Codable {
    let id: String
    let version: Int
    let createdBy: String
    let description: String
    let email: String
    let field: String
    let jobsPosted: [Job2]
    let logo: String
    let name: String
    let sector: [String]
    let size: Int
    let updatedAt: String
    let website: String
    let who: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case version = "__v"
        case createdBy, description, email, field, jobsPosted, logo, name, sector, size, updatedAt, website, who
    }
}

struct Job2: Codable {
    let id: String
    let version: Int
    let company: String
    let createdAt: String
    let jobType: String
    let location: Location
    let maxExperience, minExperience: Int
    let noOfPeople: Int
    let projectExperience, requirements, responsibilities, sectors, softwares: [Attribute]
    let salaryRangeFrom, salaryRangeTo: Int
    let sessionId: String
    let status: String
    let title: String
    let updatedAt: String
    let workPlace: String
    let yearsOfExperience: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case version = "__v"
        case company, createdAt, jobType, location, maxExperience, minExperience, noOfPeople, projectExperience, requirements, responsibilities, sectors, softwares, salaryRangeFrom, salaryRangeTo, sessionId, status, title, updatedAt, workPlace, yearsOfExperience
    }
}



struct Attribute: Codable {
    let mustHave: Int
    let selected: Int
    let title: String
}

