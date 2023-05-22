//
//  UserResource.swift
//  CodingKeysChallenge
//
//  Created by Muhammad Anum on 21/05/2023.
//

import Foundation

struct UserResource {

    func getUserLists(page: Int = 0, completion: @escaping (_ hits: [UsersResponse]?,_ error: String?)->()) {
        //check page number
        if page < 0 {
            completion(nil, "Invalid page")
            return
        }
        
        let url = URL(string: APIs.baseURL + "users?since=\(page)")
        let httpUtility = NetworkManager()
        do {
            httpUtility.getApiData(requestUrl: url!,
                                   authEnable: false,
                                   resultType: [UsersResponse].self) { response in
                _ = completion(response, nil)
            }
        }
    }
   

}
