//
//  ProfileViewModel.swift
//  CodingKeysChallenge
//
//  Created by Muhammad Anum on 21/05/2023.
//

import UIKit

class ProfileViewModel {
    
    var onShouldShowError: ((String) -> Void)?
    var onShouldRefreshItems: (() -> Void)?
    
    var profileResource = ProfileResource()
    var profileDetails: ProfileResponse?
    
    init(profile: ProfileResponse? = nil) {
        self.profileDetails = profile
    }
    
    
    func getProfile(name: String) {
        self.profileResource.getProfile(username: name) { response, error in
            if error == nil, let response = response {
                self.profileDetails = response
            }else{
                if let error = error {
                    self.onShouldShowError?(error)
                }
            }
            self.onShouldRefreshItems?()
        }
    }
}
