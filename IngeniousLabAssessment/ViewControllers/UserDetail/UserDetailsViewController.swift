//
//  UserDetailsViewController.swift
//  IngeniousLabAssessment
//
//  Created by Ban Er Win on 11/02/2022.
//

import UIKit
import Kingfisher

class UserDetailsViewController: UIViewController {
    
    var userDetails: GetUserDetail?
    var userID : Int = 0
    let LBLPhone = UILabel()
    let LBLEmail = UILabel()
    let TXTDescription = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersDetails()
        navigationController?.navigationBar.topItem?.title = userDetails?.name ?? ""
        
    }


    func getUsersDetails() {
        let url = "\(baseURL)\(detailURL)/\(userID)"
        CircularSpinner.show()
        HTTPHelper.request(url, method: .get) { [self] response in
            CircularSpinner.hide()
            let model = GetUserDetail(JSON: response)
            self.userDetails = model
            
            setupView()
        }
    }
    
    func setupView() {
        
        navigationController?.navigationBar.topItem?.title = userDetails?.name
        
        //User Image
        let image = UIImage(named: "app_logo")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: view.frame.width / 3, y: view.frame.height / 9, width: view.bounds.width / 3, height: view.bounds.height / 6)
        imageView.layer.borderColor = UIColor.systemGray5.cgColor
        imageView.layer.borderWidth = 2.0
        view.addSubview(imageView)
        imageView.kf.setImage(with: URL(string: self.userDetails?.avatar ?? ""), placeholder: UIImage(named: "Default Male"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
        
        //User email & phone
        LBLPhone.translatesAutoresizingMaskIntoConstraints = false
        LBLEmail.translatesAutoresizingMaskIntoConstraints = false
       
        LBLPhone.textAlignment = .center
        LBLPhone.layer.borderWidth = 2.0
        LBLPhone.layer.borderColor = UIColor.systemTeal.cgColor
        self.LBLPhone.text = self.userDetails?.phone ?? ""
        view.addSubview(LBLPhone)
        
        LBLEmail.textAlignment = .center
        LBLEmail.layer.borderWidth = 2.0
        LBLEmail.layer.borderColor = UIColor.systemTeal.cgColor
        self.LBLEmail.text = self.userDetails?.email ?? ""
        view.addSubview(LBLEmail)
        
        //Phone Icon
        let imagePhone = UIImage(named: "icon_call")
        let imageViewPhone = UIImageView(image: imagePhone!)
        imageViewPhone.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageViewPhone)
        
        //Email Icon
        let imageEmail = UIImage(named: "icon_email")
        let imageViewEmail = UIImageView(image: imageEmail!)
        imageViewEmail.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageViewEmail)
        
        //TextView
        self.TXTDescription.text = self.userDetails?.description ?? ""
        TXTDescription.layer.borderWidth = 2.0
        TXTDescription.layer.borderColor = UIColor.systemGray5.cgColor
        TXTDescription.font = .systemFont(ofSize: 18)
        TXTDescription.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(TXTDescription)
        
        NSLayoutConstraint.activate([
            LBLPhone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            LBLPhone.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            LBLPhone.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            LBLPhone.heightAnchor.constraint(equalToConstant: 40),
            
            LBLEmail.leadingAnchor.constraint(equalTo: LBLPhone.leadingAnchor, constant: 0),
            LBLEmail.trailingAnchor.constraint(equalTo: LBLPhone.trailingAnchor, constant: 0),
            LBLEmail.topAnchor.constraint(equalTo: LBLPhone.bottomAnchor, constant: 5),
            LBLEmail.heightAnchor.constraint(equalToConstant: 40),
            
            imageViewPhone.leadingAnchor.constraint(equalTo: LBLPhone.leadingAnchor, constant: 20),
            imageViewPhone.topAnchor.constraint(equalTo: LBLPhone.topAnchor, constant: 5),
            imageViewPhone.heightAnchor.constraint(equalToConstant: 25),
            imageViewPhone.widthAnchor.constraint(equalToConstant: 25),
            
            imageViewEmail.leadingAnchor.constraint(equalTo: LBLEmail.leadingAnchor, constant: 20),
            imageViewEmail.topAnchor.constraint(equalTo: LBLEmail.topAnchor, constant: 5),
            imageViewEmail.heightAnchor.constraint(equalToConstant: 25),
            imageViewEmail.widthAnchor.constraint(equalToConstant: 25),
            
            TXTDescription.leadingAnchor.constraint(equalTo: LBLPhone.leadingAnchor, constant: 0),
            TXTDescription.trailingAnchor.constraint(equalTo: LBLPhone.trailingAnchor, constant: 0),
            TXTDescription.topAnchor.constraint(equalTo: LBLEmail.bottomAnchor, constant: 20),
            TXTDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
      
            
               ])
        
    }

}
