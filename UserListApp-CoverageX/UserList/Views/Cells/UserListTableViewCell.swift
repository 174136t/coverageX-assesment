//
//  UserListTableViewCell.swift
//  UserListApp-CoverageX
//
//  Created by Lahiru Neranjan on 2025-06-26.
//

import UIKit

class UserListTableViewCell:UITableViewCell{
    
    private var thumbnailHeight:CGFloat = 50.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImageView.image = nil
        self.nameLabel.text = nil
    }
    
    private func configureUI(){
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        //-- add subviews and constraints
        self.contentView.addSubview(self.backGroundHolderView)
        self.backGroundHolderView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        self.backGroundHolderView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        self.backGroundHolderView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.backGroundHolderView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
    }
    
    func configureCell(with user: User) {
        self.nameLabel.text = user.displayName
        self.thumbnailImageView.loadImage(from: user.picture.thumbnail)
        }
    
    //MARK: UI Components
    private lazy var backGroundHolderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.Colors.cellBackgroundColor
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        //-- add subviews
        view.addSubview(self.thumbnailImageView)
        view.addSubview(self.nameLabel)
        
        //-- thumbnailImageView constraints
        self.thumbnailImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.thumbnailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        self.thumbnailImageView.heightAnchor.constraint(equalToConstant: self.thumbnailHeight).isActive = true
        self.thumbnailImageView.widthAnchor.constraint(equalToConstant: self.thumbnailHeight).isActive = true
        
        //-- nameLabel constraints
        self.nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.thumbnailImageView.trailingAnchor, constant: 12).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        return view
    }()
    
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = self.thumbnailHeight / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.systemGray5
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = Constants.Colors.secondaryText
        label.textAlignment = .left
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
}
