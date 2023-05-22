//
//  UserViewModel.swift
//  CodingKeysChallenge
//
//  Created by Muhammad Anum on 21/05/2023.
//

import UIKit

class UsersViewModel {
    
    var onShouldOpenDetails: ((UsersResponse) -> Void)?
    var onShouldShowError: ((String) -> Void)?
    var onShouldStartLoadingItems: ((Bool) -> Void)?
    var onShouldRefreshItems: (() -> Void)?
    var userResource = UserResource()
    
    var userList: [UsersResponse]
    var fetchingMore: Bool = false
    
    private var searchQuery: String
    private var isNewQuery: Bool
    private var currentPage: Int
    
    init(userList:[UsersResponse]? = nil) {
        
        if let list = userList {
            
            self.userList = list
        } else {
            self.userList = []
        }
        
        self.currentPage = 0
        self.searchQuery = ""
        self.isNewQuery = false
    }
    
    func fetchNextSetofHits() {
        self.currentPage += 1
        self.fetchingMore = true
        self.onShouldStartLoadingItems?(self.isNewQuery)
        self.userResource.getUserLists(page: self.currentPage) { (user, error) in
            if error == nil, let user = user {
                self.userList.append(contentsOf: user)
            }else{
                self.currentPage -= 1
                if let error = error {
                    self.onShouldShowError?(error)
                }
            }
            self.fetchingMore = false
            self.isNewQuery = false
            self.onShouldRefreshItems?()
        }
    }
    
    func fetchNewSet(query: String) {
        self.currentPage = 0
        self.userList = []
        self.searchQuery = query
        self.isNewQuery = true
        self.fetchNextSetofHits()
    }
    
    func performActionWith(user: UsersResponse) {
        self.onShouldOpenDetails?(user)
    }
}
