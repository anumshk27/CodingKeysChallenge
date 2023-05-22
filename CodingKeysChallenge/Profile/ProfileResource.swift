//
//  ProfileResource.swift
//  CodingKeysChallenge
//
//  Created by Muhammad Anum on 21/05/2023.
//

import Foundation

struct ProfileResource {
    
    func getProfile(username: String, completion: @escaping (_ hits: ProfileResponse?,_ error: String?)->()) {
        let url = URL(string: APIs.baseURL+"users/"+(username))!
        let httpUtility = NetworkManager()
        do {
            httpUtility.getApiData(requestUrl: url,
                                   authEnable: false,
                                   resultType: ProfileResponse.self) { response in
                _ = completion(response, nil)
            }
        }
    }
}
