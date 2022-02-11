//
//  ListViewController.swift
//  IngeniousLabAssessment
//
//  Created by Ban Er Win on 10/02/2022.
//

import UIKit
import Alamofire
import Kingfisher

class ListViewController: UIViewController {
    
    var arrUsers : [GetUserList] = []
    var filteredUsers = [GetUserList]()
    
    var searchController: UISearchController!
    var isSearching: Bool?
    var isSearchTapped: Bool?
    
    let tableView : UITableView = {
        let table = UITableView()
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Navigation Bar Logic
        self.title = "Inglab Assessment"
        let backImage = UIImage(named: "icon_back")!.withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        //TableView Logic
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell" )
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 100
        view.addSubview(tableView)
        
        setupViewSearch()
        getUsers()
  
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    //SearchController
    func setupViewSearch() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Users"
        searchController.searchBar.delegate = self

        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.sizeToFit()

        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
    }

    
    //API
    func getUsers() {
        let url = "\(baseURL)\(userURL)"
        CircularSpinner.show()
        HTTPHelper.request(url, method: .get) { response in
            CircularSpinner.hide()
            let model = GetUserModel(JSON: response)
            self.arrUsers = model?.responseKey ?? []
            
            //Filter isActive users only
            self.arrUsers = self.arrUsers.filter{($0.isActive! == true)}

            self.filteredUsers = self.arrUsers
            self.tableView.reloadData()
            
            
        }
    }
   

}

extension ListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //To refresh tableview with original data
        if isSearchTapped == true && isSearching == true {
            return arrUsers.count
        //To search for filtered data
        } else if isSearchTapped == true && isSearching == false {
            return filteredUsers.count
        //To return original data
        } else {
            return arrUsers.count
        }
 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        if isSearchTapped == true && isSearching == true  {
            cell.imgUser.kf.setImage(with: URL(string: self.arrUsers[indexPath.row].avatar ?? ""), placeholder: UIImage(named: "Default Male"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
            cell.imgUser.contentMode = .scaleAspectFill
            cell.LBLUser.text = self.arrUsers[indexPath.row].name
            cell.LBLPhone.text = self.arrUsers[indexPath.row].phone
        } else if isSearchTapped == true && isSearching == false  {
            cell.imgUser.kf.setImage(with: URL(string: self.filteredUsers[indexPath.row].avatar ?? ""), placeholder: UIImage(named: "Default Male"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
            cell.imgUser.contentMode = .scaleAspectFill
            cell.LBLUser.text = self.filteredUsers[indexPath.row].name
            cell.LBLPhone.text = self.filteredUsers[indexPath.row].phone
        } else {
            cell.imgUser.kf.setImage(with: URL(string: self.arrUsers[indexPath.row].avatar ?? ""), placeholder: UIImage(named: "Default Male"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
            cell.imgUser.contentMode = .scaleAspectFill
            cell.LBLUser.text = self.arrUsers[indexPath.row].name
            cell.LBLPhone.text = self.arrUsers[indexPath.row].phone
        }
        
     
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let myController = storyBoard.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        myController.userID = arrUsers[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(myController, animated: true)
    }
    
}


extension ListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        isSearchTapped = true
        isSearching = true
        tableView.reloadData()
        
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUsers = []
        isSearchTapped = true
        isSearching = false
        
        if searchText == "" {
            isSearchTapped = false
            isSearching = false
            tableView.reloadData()
        } else {
            //Filter Users & Numbers
            filteredUsers = arrUsers.filter{($0.name?.lowercased().contains(searchText.lowercased()))! || ($0.phone?.lowercased().contains(searchText.lowercased()))! }
        }
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchTapped = false
        isSearching = false

            
        tableView.reloadData()

       
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            isSearchTapped = false
            isSearching = false

            tableView.reloadData()


    }

}

extension UIViewController {
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
