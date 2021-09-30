//
//  AboutUs.swift
//  FoodDB
//
//  Created by Navid Sheikh on 26/08/2021.
//

import Foundation
import UIKit

class AboutUsController: UIViewController{
    
    
    var logo :  UIImageView  = {
        let imageView  = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image =   UIImage(named: "logo2")
        return imageView
    }()
    
    var titlePage  : UILabel =  {
        let label  = UILabel()
        label.text = " ABOUT US"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.numberOfLines =  1
        label.textAlignment = .center
        return label
    }()
    
    var aboutUsImageView : UIImageView =  {
        let imageView  = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image =   UIImage(named: "about_us_pic")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let slogan : UILabel = {
        let label  = UILabel()
        label.text = " 'There is no love sincerer than the love of food.' – George Bernard Shaw"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines =  0
        label.textAlignment = .center
        return label
    }()
    
    
    
    let mission : UILabel = {
        let label  = UILabel()
        label.text = "Gourmex was born in 2021 with the purpose of unify all existing recipes in one place. The app comprise all type of recipes and ingredients  , giving the luxury of expand your knowledge in different cuisines. If you love cooking or look for ideas for your next meal, this is the perfect place for you."
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines =  0
        label.textAlignment  = .justified
        return label
        
    }()
    
    
    let shareButton : UIButton =  {
        let button =  UIButton()
        button.setTitle("SHARE", for: .normal)
        button.backgroundColor =  .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        
    }
    
    
    private func setUpViews(){
//        view.addSubview(logo)
//        logo.anchor(top: view.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 50, paddingLeft: nil, paddingRight: nil, paddingBottom: nil, width: 200, height: 100)
//        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(titlePage)
        titlePage.anchor(top: view.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 50, paddingLeft: 0, paddingRight: 0, paddingBottom: nil, width: nil, height: 100)
        titlePage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        
        view.addSubview(slogan)
        slogan.anchor(top: titlePage.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: nil, width: nil, height: nil)
        
        view.addSubview(aboutUsImageView)
        aboutUsImageView.anchor(top: slogan.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: nil, width: nil, height: 200)
        
        view.addSubview(mission)
        mission.anchor(top: aboutUsImageView.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: nil, width: nil, height: nil)
        
        
        
        view.addSubview(shareButton)
        shareButton.anchor(top: nil, left: nil, right: nil, bottom: view.bottomAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: -75, width: 150, height: 40)
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shareButton.addTarget(self, action: #selector(presentShareSheet), for: .touchUpInside)
    }
    
    
    @objc private func presentShareSheet(_ sender: UIButton  ){
        guard  let url  =  URL(string: "https://google.com") else{
            return
        }
        
        let shareSheetVc  =  UIActivityViewController(
            activityItems: [ url],
            applicationActivities: nil
        )
        // Ipad suppoty
        
        shareSheetVc.popoverPresentationController?.sourceView = sender
        shareSheetVc.popoverPresentationController?.sourceRect = sender.frame

        present(shareSheetVc, animated: true, completion: nil)
        
    }
}

