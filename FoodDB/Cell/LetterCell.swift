//
//  LetterCell.swift
//  FoodDB
//
//  Created by Navid Sheikh on 24/07/2021.
//

import Foundation
import UIKit



class LetterCell: CustomCell {
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderWidth = isSelected ? 2.0 : 0
            self.layer.borderColor =  isSelected ?  UIColor.systemGray6.cgColor :  UIColor.clear.cgColor
            self.backgroundColor = isSelected ?  UIColor.systemGray6 :  UIColor.clear
        }
    }
    
    
    let label  : UILabel =  {
        let label  = UILabel()
        label.text = "A"
        label.font  = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  .black
        label.textAlignment =  .center
        return label
    }()
    
    override func setUpCell() {
        addSubview(label)
        label.anchor(top: topAnchor, left: leadingAnchor, right: trailingAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    }
    
}
