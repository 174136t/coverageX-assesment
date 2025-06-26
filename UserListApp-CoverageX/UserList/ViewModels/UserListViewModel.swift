//
//  UserListViewModel.swift
//  UserListApp-CoverageX
//
//  Created by Lahiru Neranjan on 2025-06-26.
//

import Foundation

protocol UserListViewModelDelegate:AnyObject{
    func updateUserList()
    func startLoading()
    func finishLoading()
    func failWithError(error:String)
}

class UserListViewModel{
    weak var delegate:UserListViewModelDelegate?
    
    private(set) var usersList: [User] = []
    private(set) var isLoading = false
    
    func fetchUsersList(){
        isLoading = true
        delegate?.startLoading()
        
        UserService.shared.fetchUsersList{[weak self] response in
            DispatchQueue.main.async{
                self?.isLoading = false
                self?.delegate?.finishLoading()
                
                switch response{
                case .success(let usersList):
                    self?.usersList = usersList
                    self?.delegate?.updateUserList()
                    
                case .failure(let error):
                    self?.delegate?.failWithError(error: error.localizedDescription)
                }
            }
        }
    }
    
    func getUser(at index:Int) -> User?{
        guard index < usersList.count else{
            return nil
        }
        
        return usersList[index]
    }
    
    var totalUserCount:Int{
        return usersList.count
    }
}
