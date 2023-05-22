//
//  ProfileController.swift
//  CodingKeysChallenge
//
//  Created by Muhammad Anum on 21/05/2023.
//

import UIKit
import SDWebImage

class ProfileController: UIViewController {
    
    var activityIndicator : ActivityIndicatorView!
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    @IBOutlet weak var followerTxt: UILabel!
    @IBOutlet weak var followingTxt: UILabel!
    @IBOutlet weak var reposTxt: UILabel!
    
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var companyTxt: UILabel!
    @IBOutlet weak var blogTxt: UILabel!
    
    var user: UsersResponse!
    var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewModel()
        self.viewModel.getProfile(name: user.login)
    }
    
    func configureView() {
        
        self.navigationItem.title = user.login
        activityIndicator = ActivityIndicatorView(onView: view, andStartAnimation: false)

        let backImg = #imageLiteral(resourceName: "ic_leftArrow")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImg,
                                                                style:.plain,
                                                                target: self,
                                                                action: #selector(didTapBackBtn))
    }
    
    @objc func didTapBackBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func configureViewModel() {
        activityIndicator.startAnimating()
        self.viewModel.onShouldRefreshItems = { [weak self] in
            DispatchQueue.main.async {
                self?.configureDataSet()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    func configureDataSet() {
        
        self.followerTxt.text = "\(self.viewModel.profileDetails?.followers ?? 0)"
        self.followingTxt.text = "\(self.viewModel.profileDetails?.following ?? 0)"
        self.reposTxt.text = "\(self.viewModel.profileDetails?.public_repos ?? 0)"
        
        self.nameTxt.text = user.login
        self.companyTxt.text = self.viewModel.profileDetails?.company
        self.blogTxt.text = self.viewModel.profileDetails?.blog
        
        avatarImg.sd_setImage(with: URL(string: user.avatar_url ?? ""), placeholderImage: UIImage(named: "defaultImage"))
        avatarImg.setRounded()
    }
}


