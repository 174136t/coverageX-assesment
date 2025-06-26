//
//  UserListViewController.swift
//  UserListApp-CoverageX
//
//  Created by Lahiru Neranjan on 2025-06-26.
//

import UIKit

class UserListViewController: UIViewController {
    private let viewModel = UserListViewModel()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.configureUI()
        self.setupViewModel()
        self.viewModel.fetchUsersList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        self.view.backgroundColor = Constants.Colors.backgroundColor
        
        //-- add subviews
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.userListTableView)
        self.view.addSubview(self.loadingView)
        
        //-- titleLabel constraints
        self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        //-- userListCollectionView constraints
        self.userListTableView.refreshControl = self.refreshControl
        self.userListTableView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        self.userListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.userListTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.userListTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        //-- loadingView constraints
        self.loadingView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.loadingView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    private func setupViewModel() {
        self.viewModel.delegate = self
    }
    
    //MARK: UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "User List"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = Constants.Colors.primaryText
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.backgroundColor = .clear
        
        return label
    }()
    
    private lazy var userListTableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: Constants.CellIdentifiers.userListCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.isUserInteractionEnabled = true
        tableView.clipsToBounds = true
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.translatesAutoresizingMaskIntoConstraints = false
        refresh.addTarget(self, action: #selector(refreshUsers), for: .valueChanged)
        return refresh
    }()
    
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.Colors.backgroundColor
        
        //-- add subviews
        view.addSubview(self.activityIndicator)
        view.addSubview(self.loadingLabel)
        
        //-- activityIndicator constraints
        self.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //-- loadingLabel constraints
        self.loadingLabel.topAnchor.constraint(equalTo: self.activityIndicator.bottomAnchor, constant: 10).isActive = true
        self.loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.isHidden = true
        
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .systemBlue
        return indicator
    }()
    
    private lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading Users List..."
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = Constants.Colors.secondaryText
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Actions
    @objc private func refreshUsers() {
        self.viewModel.fetchUsersList()
    }
    
    private func navigateToUserDetail(for user: User) {
        let detailViewModel = UserDetailViewModel(user: user)
        let detailVC = UserDetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

//MARK: UITableViewDataSource Methods
extension UserListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.totalUserCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.userListCellIdentifier,
                                                       for: indexPath) as? UserListTableViewCell,
              let user = self.viewModel.getUser(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.configureCell(with: user)
        return cell
    }
    
    
}

//MARK: UITableViewDelegate Methods
extension UserListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let user = self.viewModel.getUser(at: indexPath.row) else { return }
        navigateToUserDetail(for: user)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
}


//MARK: UserListViewModelDelegate Methods
extension UserListViewController: UserListViewModelDelegate{
    func updateUserList() {
        self.userListTableView.reloadData()
    }
    
    func startLoading() {
        if self.refreshControl.isRefreshing {
            return
        }
        
        self.loadingView.isHidden = false
        self.activityIndicator.startAnimating()
        self.userListTableView.isHidden = true
    }
    
    func finishLoading() {
        self.refreshControl.endRefreshing()
        self.loadingView.isHidden = true
        self.activityIndicator.stopAnimating()
        self.userListTableView.isHidden = false
    }
    
    func failWithError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { _ in
            self.viewModel.fetchUsersList()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
}
