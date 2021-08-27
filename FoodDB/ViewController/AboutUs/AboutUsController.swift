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
    
    
    let slogan : UILabel = {
        let label  = UILabel()
        label.text = "This is something"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines =  0
        label.textAlignment = .center
        return label
    }()
    
    
    
    let mission : UILabel = {
        let label  = UILabel()
        label.text = "This is somethinjdsjvnwvj  jdwnvdjvnsjvsv ddovsdnvdsvodsmvdk sncodsividsvd nkovdnvkdvkdsnvjdsnvsd jv sdjvndsj  jcdsnvdjsvnog"
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
        view.addSubview(logo)
        logo.anchor(top: view.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 50, paddingLeft: nil, paddingRight: nil, paddingBottom: nil, width: 200, height: 100)
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(slogan)
        slogan.anchor(top: logo.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: nil, width: nil, height: nil)
        
        view.addSubview(mission)
        mission.anchor(top: slogan.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: nil, width: nil, height: nil)
        
        
        
        view.addSubview(shareButton)
        shareButton.anchor(top: mission.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 150, height: 40)
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shareButton.addTarget(self, action: #selector(presentShareSheet), for: .touchUpInside)
    }
    
    
    @objc private func presentShareSheet(_ sender: UIButton  ){
        guard let image =  UIImage(named: "food3") , let url  =  URL(string: "https://google.com") else{
            return
        }
        
        let shareSheetVc  =  UIActivityViewController(
            activityItems: [image, url],
            applicationActivities: nil
        )
        // Ipad suppoty
        
        shareSheetVc.popoverPresentationController?.sourceView = sender
        shareSheetVc.popoverPresentationController?.sourceRect = sender.frame

        present(shareSheetVc, animated: true, completion: nil)
        
    }
}

