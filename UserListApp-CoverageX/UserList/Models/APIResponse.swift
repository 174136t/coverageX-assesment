//
//  APIResponse.swift
//  UserListApp-CoverageX
//
//  Created by Lahiru Neranjan on 2025-06-26.
//

import Foundation

struct APIResponse:Codable{
    let results: [User]
//    let info: APIInfo
}

//struct APIInfo: Codable {
//    let seed: String
//    let results: Int
//    let page: Int
//    let version: String
//}
