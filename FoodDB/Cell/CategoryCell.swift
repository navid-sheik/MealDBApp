//
//  CategoryCell.swift
//  FoodDB
//
//  Created by Navid Sheikh on 15/07/2021.
//

import Foundation
import UIKit

class CategoryCell :  CustomCell {
    
    var individualCategory : Category? {
        didSet{
            guard  let category  =  individualCategory else {
                return
            }
            categoryLabel.text =  category.category
            guard let urlThumbnail = category.thumbnail else {
                return
            }
            categoryImageView.loadImageUrlString(urlString: urlThumbnail)
        }
    }
    
    let categoryImageView : CustomImageView =  {
        let imageView =  CustomImageView()
        imageView.contentMode =  .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "placeholder")
        imageView.backgroundColor =  .init(white: 0.9, alpha: 0.5)
        return imageView
    }()
    
    
    let categoryLabel  :  UILabel =  {
        let label  = UILabel ()
        label.font =  UIFont.boldSystemFont(ofSize: 14)
        label.text  = "CATEGORY"
        label.textColor =  .white
        label.textAlignment =  .center
        label.backgroundColor = .black
        return label
    }()
    
    override func setUpCell() {
        addSubview(categoryImageView)
        categoryImageView.anchor(top: topAnchor, left: leadingAnchor, right: trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: contentView.frame.width - 25)
        addSubview(categoryLabel)
        categoryLabel.anchor(top: categoryImageView.bottomAnchor, left: leadingAnchor, right: trailingAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    }
    
}
