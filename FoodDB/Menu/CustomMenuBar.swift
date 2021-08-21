//
//  CustomMenuBar.swift
//  FoodDB
//
//  Created by Navid Sheikh on 15/08/2021.
//

import Foundation
import UIKit


class CustomMenuBar  : UIView {
    
    let buttonBarItem  : UIButton =  {
        let button =  UIButton ()
        button.setImage(UIImage(named: "hamburger"), for: .normal)
        //button.backgroundColor =  .darkGray
        return button
    }()
    
    let imageLogo  :  UIImageView =  {
        let imageView  = UIImageView()
        imageView.image =  UIImage(named: "logo2")
        imageView.contentMode  = .scaleToFill
        //imageView.backgroundColor = .blue
        
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(buttonBarItem)
        buttonBarItem.anchor(top: nil, left: leadingAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        buttonBarItem.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(imageLogo)
        imageLogo.anchor(top: nil, left: buttonBarItem.trailingAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 5, paddingRight: 0 , paddingBottom: 0, width: 180, height: 35)
        imageLogo.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


