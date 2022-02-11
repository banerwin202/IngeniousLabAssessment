//
//  ListTableViewCell.swift
//  IngeniousLabAssessment
//
//  Created by Ban Er Win on 11/02/2022.
//

import UIKit
import Foundation

class ListTableViewCell: UITableViewCell {
    
    let imgUser = UIImageView()
    let LBLUser = UILabel()
    let LBLPhone = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imgUser.translatesAutoresizingMaskIntoConstraints = false
        LBLUser.translatesAutoresizingMaskIntoConstraints = false
        LBLPhone.translatesAutoresizingMaskIntoConstraints = false
        
        //Constraints
        contentView.addSubview(imgUser)
        contentView.addSubview(LBLUser)
        contentView.addSubview(LBLPhone)
        
        NSLayoutConstraint.activate([
            imgUser.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            imgUser.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imgUser.heightAnchor.constraint(equalToConstant: 80),
            imgUser.widthAnchor.constraint(equalToConstant: 80),
            
            
            LBLUser.leadingAnchor.constraint(equalTo: imgUser.trailingAnchor, constant: 30),
            LBLUser.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            LBLUser.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            LBLPhone.leadingAnchor.constraint(equalTo: LBLUser.leadingAnchor, constant: 0),
            LBLPhone.topAnchor.constraint(equalTo: LBLUser.bottomAnchor, constant: 5),
            LBLPhone.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            
               ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}
