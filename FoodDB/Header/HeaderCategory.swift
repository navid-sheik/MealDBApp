//
//  HeaderCategory.swift
//  FoodDB
//
//  Created by Navid Sheikh on 15/07/2021.
//

import Foundation
import UIKit

protocol ReloadHeaderDelegate {
    func reloadCollectioView()
}

class Headercategory :  UICollectionReusableView{
    var individualCategory: Category?{
        didSet{
            //categoryTitle.text =  individualCategory?.category
            guard let thumbnailString = individualCategory?.thumbnail else {
                return
            }
            individualCategoryImg.loadImageUrlString(urlString: thumbnailString)
            categorySummary.text =  individualCategory?.description
            //delegate?.reloadCollectioView()
        }
    }
    
    
    var delegate : ReloadHeaderDelegate?
    
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
    
    
    let individualCategoryImg : CustomImageView  = {
        let imageView  = CustomImageView()
        imageView.image =  UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor =  .init(white: 0.9, alpha: 0.5)
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
    
    let descriptionScrollView :  UIScrollView =  {
        let sv =  UIScrollView()
        
        
        return sv
    }()
    
    let contentView : UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
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
        
        //categoryTitle.anchor(top:  randomView.topAnchor, left: randomView.leadingAnchor, right: randomView.trailingAnchor, bottom: nil, paddingTop: 5, paddingLeft: 0, paddingRight: 0, paddingBottom: nil, width: nil, height: 50)
        individualCategoryImg.anchor(top: self.randomView.topAnchor, left: randomView.leadingAnchor, right: randomView.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: nil, width: nil, height: 200)
        
        
        addSubview(descriptionScrollView)
        //make sure look bottom paddding of the last element
        descriptionScrollView.addSubview(contentView)
        descriptionScrollView.translatesAutoresizingMaskIntoConstraints = false
        descriptionScrollView.topAnchor.constraint(equalTo: individualCategoryImg.bottomAnchor, constant: 5).isActive = true
        descriptionScrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        descriptionScrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        descriptionScrollView.heightAnchor.constraint(equalToConstant: 112).isActive = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: descriptionScrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: descriptionScrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: descriptionScrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: descriptionScrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: descriptionScrollView.widthAnchor).isActive = true
        
        
        
        contentView.addSubview(categorySummary)
        
        
        
        categorySummary.anchor(top: contentView.topAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor, paddingTop: 10, paddingLeft: 2, paddingRight: -2, paddingBottom: -10, width: nil, height: nil)
        
    }
}
