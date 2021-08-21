//
//  MenuCell.swift
//  FoodDB
//
//  Created by Navid Sheikh on 06/08/2021.
//

import Foundation
import UIKit


class MenuCell: CustomCell {
    
    let label : UILabel   =  {
        let label  = UILabel ()
        label.text = "Home"
        label.font  = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment =  .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .white
        return label
        
    }()
    
    let iconMenu : UIImageView =  {
        let imageView  = UIImageView()
        imageView.contentMode =  .scaleAspectFit
        imageView.image =  UIImage(systemName: "house")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func setUpCell() {
        super.setUpCell()
        addSubview(iconMenu)
        iconMenu.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        iconMenu.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconMenu.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iconMenu.widthAnchor.constraint(equalToConstant: 30).isActive = true
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: iconMenu.trailingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
