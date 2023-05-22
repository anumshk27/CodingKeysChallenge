//
//  UsersResponse.swift
//  CodingKeysChallenge
//
//  Created by Muhammad Anum on 21/05/2023.
//

import Foundation

struct UsersResponse: Decodable {
    
    let login: String
    let id: Int?
    let node_id: String?
    let avatar_url: String?
    let gravatar_id: String?
    let url, html_url: String?
    let followers_url, following_url: String?
    let starred_url, gists_url: String?
    let subscriptions_url, organizations_url, repos_url: String?
    let events_url, received_events_url: String?
    let receivedEventsURL: String?
  
}
