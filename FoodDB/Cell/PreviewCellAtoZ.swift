//
//  PreviewMealAtoZ.swift
//  FoodDB
//
//  Created by Navid Sheikh on 24/07/2021.
//

import Foundation
import UIKit

class PreviewCellAtoZ: UITableViewCell {
    
    
    let previewImageView : CustomImageView =  {
        let imageView =  CustomImageView()
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "placeholder")
        return imageView
    }()
    
    var titleMeal : UILabel  = {
        let label =  UILabel ()
        label.text =  "The meal title"
        //label.backgroundColor  =  .red
        
        label.font =  UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews(){
        
        
        
        addSubview(previewImageView)
        previewImageView.anchor(top: topAnchor, left: nil, right: trailingAnchor, bottom: bottomAnchor, paddingTop: 5, paddingLeft: 0, paddingRight: -5, paddingBottom: -5, width: 100, height: nil)
        
        addSubview(titleMeal)
        titleMeal.anchor(top: topAnchor, left: leadingAnchor, right: previewImageView.leadingAnchor, bottom: nil, paddingTop: 5, paddingLeft: 5, paddingRight: -5, paddingBottom: nil, width: nil, height: 50)
    }
}
