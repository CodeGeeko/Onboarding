//
//  Tutorial.swift
//  Onboarding
//
//  Created by Kuldeep Bhatt on 2021/08/22.
//

import Foundation

// MARK: - Tutorials
struct Tutorials: Codable {
    let tutorials: [Tutorial]
}

// MARK: - Tutorial
struct Tutorial: Codable {
    let teacherName, topicName: String
    let videoBannerURL: String
    let tutorialURL: String
    let badge: String
    let avgRatings: Double
    let views, kudos, duration: Int
    
    enum CodingKeys: String, CodingKey {
        case teacherName, topicName
        case videoBannerURL = "videoBannerUrl"
        case tutorialURL = "tutorialUrl"
        case badge, avgRatings, views, kudos, duration
    }
}

enum Badge: String, Codable {
    case Bronze = "BRONZE"
    case Silver = "SILVER"
    case Gold = "GOLD"
    case Diamond = "DIAMOND"
}
