//
//  TagCell.swift
//  FoodDB
//
//  Created by Navid Sheikh on 27/07/2021.
//

import Foundation
import UIKit

class TagCell :  CustomCell{
    
    var tagName :  UILabel = {
        let label = UILabel ()
        label.text = "tag"
        label.sizeToFit()
        label.font =  UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .white
        //label.backgroundColor = .black
        return label
    }()
    
    override func setUpCell() {
        //stylingCell()
        contentView.addSubview(tagName)
        tagName.anchor(top: topAnchor, left: leadingAnchor, right: trailingAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    }
    
    
    private func stylingCell(){
        self.contentView.layer.borderWidth =  1.0
        self.contentView.layer.borderColor =  UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor =  UIColor.black.cgColor
        self.layer.shadowOffset =  CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius =  2.0
        self.layer.shadowOpacity =  0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    
}
