//
//  User.swift
//  UserListApp-CoverageX
//
//  Created by Lahiru Neranjan on 2025-06-26.
//

import Foundation

struct User:Codable{
    let gender: String
    let name: Name
    let email: String
    let phone: String
    let picture: Picture
    
    var fullName: String {
        return "\(name.title). \(name.first) \(name.last)"
    }
    
    var displayName: String {
        return "\(name.first) \(name.last)"
    }
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
