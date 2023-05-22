//
//  ProfileResponse.swift
//  CodingKeysChallenge
//
//  Created by Muhammad Anum on 21/05/2023.
//

import Foundation

struct ProfileResponse: Decodable {
    
    let blog: String
    let name, company: String?
    let followers, following: Int
    let public_repos: Int?
    
}
