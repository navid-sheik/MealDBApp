//
//  LabelTop.swift
//  FoodDB
//
//  Created by Navid Sheikh on 16/07/2021.
//

import Foundation

import UIKit
class LabelTop : UILabel {
    
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: super.intrinsicContentSize.width, height: super.intrinsicContentSize.height - 100)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
