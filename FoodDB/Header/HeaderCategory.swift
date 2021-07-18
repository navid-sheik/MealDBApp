//
//  HeaderCategory.swift
//  FoodDB
//
//  Created by Navid Sheikh on 15/07/2021.
//

import Foundation
import UIKit

class Headercategory :  UICollectionReusableView{
    
    
    let randomView : UIView  = {
        let view =  UIView()
        
        return view
    }()
    
    let categoryTitle  : UILabel = {
        let label  = UILabel()
        label.text =  "Category"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font =  UIFont.boldSystemFont(ofSize: 25)
        //label.backgroundColor = .blue
        return label
    }()
    
    
    let individualCategoryImg : UIImageView  = {
        let imageView  = UIImageView()
        imageView.image =  UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    let categorySummary  : UILabel = {
        let label  = UILabel()
        label.text =  "Some description that has a long test show that it's justified becuase it's time to do something that has been something "
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font =  UIFont.systemFont(ofSize: 14)
        //label.backgroundColor =  .darkGray
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpViews(){
        
        addSubview(randomView)
        randomView.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 5, paddingRight: -5, paddingBottom: 0, width: nil, height: nil)
        
        randomView.addSubview(categoryTitle)
        randomView.addSubview(individualCategoryImg)
        randomView.addSubview(categorySummary)
        
        categoryTitle.anchor(top:  randomView.topAnchor, left: randomView.leadingAnchor, right: randomView.trailingAnchor, bottom: nil, paddingTop: 5, paddingLeft: 0, paddingRight: 0, paddingBottom: nil, width: nil, height: 50)
        individualCategoryImg.anchor(top: self.categoryTitle.bottomAnchor, left: randomView.leadingAnchor, right: randomView.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: nil, width: nil, height: 200)
        categorySummary.anchor(top: individualCategoryImg.bottomAnchor, left: randomView.leadingAnchor, right: randomView.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 2, paddingRight: -2, paddingBottom: nil, width: nil, height: 100)
        
    }
}
