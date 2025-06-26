//
//  UserDetailViewController.swift
//  UserListApp-CoverageX
//
//  Created by Lahiru Neranjan on 2025-06-26.
//

import UIKit

class UserDetailViewController:UIViewController{
    private let viewModel: UserDetailViewModel
    private var profileImageHeight:CGFloat = 200.0
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.configUI()
        self.configureUserDataWithViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI(){
        title = "User Details"
        self.view.backgroundColor = Constants.Colors.backgroundColor
        
        //-- add subviews
        self.view.addSubview(self.profileImageView)
        self.view.addSubview(self.contentHolderView)
                
        //-- profileImageView constraints
        self.profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: self.profileImageHeight).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: self.profileImageHeight).isActive = true
        
        //-- contentHolderView constraints
        self.contentHolderView.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 8).isActive = true
        self.contentHolderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.contentHolderView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32).isActive = true
        self.contentHolderView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        //--
        self.setupDetailPointViews()
    }
    
    private func configureUserDataWithViewModel() {
        nameLabel.text = viewModel.fullName
        
        if let imageURL = viewModel.largeProfilePicURL {
            profileImageView.loadImage(from: imageURL.absoluteString)
        }
    }
    
    private func createDetailPointView(title: String, value: String, icon: String) -> UIView {
        //--
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = Constants.Colors.detailPointBackgroundColor
        containerView.layer.cornerRadius = 8
        
        //--
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = .systemBlue
        iconImageView.contentMode = .scaleAspectFit
        
        //--
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = Constants.Colors.secondaryText
        
        //--
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        valueLabel.textColor = Constants.Colors.primaryText
        valueLabel.numberOfLines = 0
        
        //--
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        
        //--
        containerView.addSubview(iconImageView)
        containerView.addSubview(stackView)
        
        //--
        iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        //--
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        
        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        
        
        return containerView
    }
    
    private func setupDetailPointViews() {
        let emailView = self.createDetailPointView(title: "Email", value: self.viewModel.email, icon: "envelope")
        let phoneView = self.createDetailPointView(title: "Phone", value: self.viewModel.phone, icon: "phone")
        let genderView = self.createDetailPointView(title: "Gender", value: self.viewModel.gender, icon: "person")
        
        self.detailsStackView.addArrangedSubview(emailView)
        self.detailsStackView.addArrangedSubview(phoneView)
        self.detailsStackView.addArrangedSubview(genderView)
    }
    
    //MARK: UI Components
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = self.profileImageHeight / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.systemGray5
        
        return imageView
    }()
    
    private lazy var contentHolderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.Colors.cellBackgroundColor
        view.layer.cornerRadius = 8
        
        //-- add subviews
        view.addSubview(self.nameLabel)
        view.addSubview(self.detailsStackView)
        
        //-- nameLabel constraints
        self.nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        self.nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //-- detailsStackView constraints
        self.detailsStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        self.detailsStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        self.detailsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.detailsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = Constants.Colors.primaryText
        label.textAlignment = .left
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        
        return stack
    }()
    
}
