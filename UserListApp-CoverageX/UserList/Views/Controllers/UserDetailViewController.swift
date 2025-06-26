//
//  UserDetailViewController.swift
//  UserListApp-CoverageX
//
//  Created by Lahiru Neranjan on 2025-06-26.
//

import UIKit

class UserDetailViewController:UIViewController{
    private let viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI(){
        self.view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    //MARK: UI Components
    
}
