//
//  HelpController.swift
//  FoodDB
//
//  Created by Navid Sheikh on 26/08/2021.
//

import Foundation
import UIKit
import MessageUI
import SafariServices

class HelpController : UIViewController, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate{
    
    
    
    
    
    var logo :  UIImageView  = {
        let imageView  = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image =   UIImage(named: "logo2")
        return imageView
    }()
    
    
    let hoursLabel : UILabel = {
        let label  = UILabel()
        label.text = "Our customer service hours are available 24/7."
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines =  0
        label.textAlignment = .center
        return label
    }()
    
    
    
    let descriptionLabel : UILabel = {
        let label  = UILabel()
        label.text = "Our representatives return emails in the order in which they are received. Due to the way our system is programmed, sending multiple emails may delay our response time. Please only send one message and we will get back to you as soon as possible."
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines =  0
        label.textAlignment  = .justified
        return label
        
    }()
    
    let emailLabel : UILabel  = {
        let label  = UILabel()
        let attributext =  NSMutableAttributedString(string: "Email: ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14) ])
        let emailAttributedText  = NSMutableAttributedString(string: "gourmex@gmail.com", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14) ])
        attributext.append(emailAttributedText)
        label.attributedText =  attributext
        label.numberOfLines =  0
        label.textAlignment  = .left
        
        return label
    }()
    
    
    
    let locationLabel : UILabel  = {
        let label  = UILabel()
        let attributext =  NSMutableAttributedString(string: "Location: ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14) ])
        let emailAttributedText  = NSMutableAttributedString(string: "City of Industry, CA 91745, USA", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14) ])
        attributext.append(emailAttributedText)
        label.attributedText =  attributext
        label.numberOfLines =  0
        label.textAlignment  = .left
        return label
    }()
    
    
    
    let emailButton : UIButton =  {
        let button =  UIButton()
        button.setTitle("CONTACT US", for: .normal)
        button.backgroundColor =  .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func setUpViews(){
        view.addSubview(logo)
        logo.anchor(top: view.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 50, paddingLeft: nil, paddingRight: nil, paddingBottom: nil, width: 200, height: 100)
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(hoursLabel)
        hoursLabel.anchor(top: logo.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: nil, width: nil, height: nil)
        
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: hoursLabel.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: nil, width: nil, height: nil)
        
        view.addSubview(emailLabel)
        emailLabel.anchor(top: descriptionLabel.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: nil, width: nil, height: nil)
        
        view.addSubview(locationLabel)
        
        locationLabel.anchor(top: emailLabel.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: nil, width: nil, height: nil)
    
        
        
        
        view.addSubview(emailButton)
        emailButton.anchor(top: nil , left: nil, right: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: -75, width: 150, height: 40)
        emailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
    }
    
    @objc private func sendEmail (){
        if MFMailComposeViewController.canSendMail(){
            let vc =  MFMailComposeViewController()
            vc.delegate = self
            vc.setSubject("Contact Us/ FeedBack")
            vc.setToRecipients(["navidsheikh54@gmail.com"])
            vc.setMessageBody("<h1>Hello </h1>", isHTML: true)
            present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            
        }
        else{
            
            guard let url = URL(string: "https://google.com") else {
                return
            }
            let vc =  SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
            
        }
        
    
    }
    
    
}
