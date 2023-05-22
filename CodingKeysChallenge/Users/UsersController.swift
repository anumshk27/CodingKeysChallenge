//
//  UserController.swift
//  CodingKeysChallenge
//
//  Created by Muhammad Anum on 21/05/2023.
//

import UIKit

class UsersController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
        
    var viewModel = UsersViewModel()
    var loadingCell:LoadingCell!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViewController()
        self.configureTableViewCells()
        self.configureViewModel()
        self.viewModel.fetchNextSetofHits()
        
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Github"
    }
    
    
    // collection view setup
    private func configureTableViewCells() {
        
        //assign to cell the Xib file
        tableView?.register(LoadingCell.nib, forCellReuseIdentifier: LoadingCell.identifier)
        tableView?.register(UserCell.nib, forCellReuseIdentifier: UserCell.identifier)

    }
    
    private func configureViewModel() {
        self.viewModel.onShouldRefreshItems = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        self.viewModel.onShouldStartLoadingItems = { [weak self] isNewQuery in
            DispatchQueue.main.async {
                if isNewQuery {
                    self?.tableView.reloadData()
                }
                self?.tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .none)
            }
        }
        
        self.viewModel.onShouldShowError = { [weak self] error in
            DispatchQueue.main.async {
                self?.popupAlert(title: "Error", message: error, actionTitles: ["OK"], actions: [nil])
            }
        }
        
        self.viewModel.onShouldOpenDetails = { [weak self] users in
            //open details viewcontroller with the hit
            let dController = self?.storyboard?.instantiateViewController(identifier: "ProfileController") as! ProfileController
            dController.user = users
            self?.navigationController?.pushViewController(dController, animated: true)
        }
    }
}


//MARK:- Data Source & Delegate

extension UsersController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.userList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == self.viewModel.userList.count  {
            let cell: LoadingCell = tableView.dequeue(cellForItemAt: indexPath) as LoadingCell
            self.loadingCell = cell
            cell.loading.startAnimating()
            return cell
        }else {
            let cell: UserCell = tableView.dequeue(cellForItemAt: indexPath) as UserCell
            cell.configureCell(user: self.viewModel.userList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if self.viewModel.userList.count > indexPath.row {
            let user = self.viewModel.userList[indexPath.row]
            self.viewModel.performActionWith(user: user)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.loadingCell != nil {
            if isVisible(view: self.loadingCell) && self.viewModel.fetchingMore == false {
                self.viewModel.fetchNextSetofHits()
            }
        }
    }
    
    public func isVisible(view: UIView) -> Bool {
        
        if view.window == nil {
            return false
        }
        
        var currentView: UIView = view
        while let superview = currentView.superview {
            
            if (superview.bounds).intersects(currentView.frame) == false {
                return false;
            }
            
            if currentView.isHidden {
                return false
            }
            
            currentView = superview
        }
        
        return true
    }
}



