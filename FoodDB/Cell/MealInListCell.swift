//
//  InvidualMealInList.swift
//  FoodDB
//
//  Created by Navid Sheikh on 16/07/2021.
//

import Foundation
import UIKit

class MealInListCell: CustomCell {
    
    var categoryListView:  CategoryListIndividual? {
        didSet{
            guard let thumNailUrl = categoryListView?.strMealThumb else {
                return
            }
            categoryImageView.loadImageUrlString(urlString: thumNailUrl)
        }
    }
    let categoryImageView : CustomImageView =  {
        let imageView =  CustomImageView()
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "placeholder")
        return imageView
    }()
    

    
    override func setUpCell() {
        addSubview(categoryImageView)
        categoryImageView.anchor(top: topAnchor, left: leadingAnchor, right: trailingAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
    }
    
}
