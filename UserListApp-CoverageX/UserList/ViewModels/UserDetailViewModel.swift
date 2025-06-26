//
//  UserDetailViewModel.swift
//  UserListApp-CoverageX
//
//  Created by Lahiru Neranjan on 2025-06-26.
//

import Foundation

class UserDetailViewModel{
    private let user:User
    
    init(user: User) {
        self.user = user
    }
    
    var gender:String{
        return user.gender
    }
    
    var fullName:String{
        return user.fullName
    }
    
    var email:String{
        return user.email
    }
    
    var phone:String{
        return user.phone
    }
    
    var largeProfilePicURL:URL?{
        return URL(string: user.picture.large)
    }
}
