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
    let experience: [Experience]
    let softwares: [Software]
    let sectors: [Sector]
    let projectExperience: [ProjectExperience]
    let responsibilities: [Responsibility]
    let requirements: [Requirement]
    let yearsOfExperience: String
    let createdAt: String
    let updatedAt: String
    let workPlace: String?
    let companyName: String
    let companyLogo: String

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

