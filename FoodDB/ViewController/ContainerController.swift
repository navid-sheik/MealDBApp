//
//  ContainerController.swift
//  FoodDB
//
//  Created by Navid Sheikh on 07/08/2021.
//

import Foundation
import UIKit

class ContainerController : UIViewController {
    
    
    var centerController : UIViewController!
    var menuController  :  MenuController!
    var internetConnectionController :  NoInternetConnection!
    var isExpanded : Bool =  false
    
    
    //Load view
    override func viewDidLoad() {
        super.viewDidLoad()
        //NetworkMonitor.shared.delegate = self
        view.backgroundColor =  .black

        loadMainView()
        //monitorNetwork()
 
    }
    
    //To perfect
//    private func monitorNetwork (){
//        if NetworkMonitor.shared.isConnected{
//            print("vv")
//            
//        }else {
//            loadNoInternetConnnection()
//            animateNoInternet(internetConnection: true)
//        }
//        
//    }
    
    //Load Main Tab Controller, tabController intialize first its view controllers
    private func loadMainView(){
        let mainController = MealTabController()
        mainController.delegateToggle = self
        mainController.resetDelegate()
        centerController =  mainController
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    //Load the menu only once,single instance
    private func loadMenu(){
        if menuController == nil{
            menuController =  MenuController()
            menuController.delegate = self
            //view.insertSubview(menuController.view, aboveSubview: centerController.view)
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    
    private func animateMenu (shouldExpand: Bool, settingOption : SettingsV2?){
        if shouldExpand{
            //Show menu
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.centerController.view.frame.origin.x =  self.centerController.view.frame.width - 56
                //self.menuController.view.frame.size.width = self.centerController.view.frame.width - 56
                self.centerController.view.alpha =  0.5
            }, completion :nil)
            
        }else {
            
            //Hide menu
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn) {
                self.centerController.view.frame.origin.x =  0
                //self.menuController.view.frame.size.width  = 0
                self.centerController.view.alpha =  1
            } completion: { (_) in
                guard let setting =  settingOption else {
                    return
                }
                self.navigateToSingleSettingPage(setting: setting)
              
            }
            
        }
        animateStatusBar()
    }
    
    //present single controller
    private func navigateToSingleSettingPage(setting :  SettingsV2?){
        switch setting{
        
        case .Home:
           return
     
        case .none:
            return
        case .some(.Help):
            let  controller  = HelpController()
            //controller.view.backgroundColor  = .yellow
            self.present(controller, animated: true, completion: nil)
        case .some(.AboutUs):
            let  controller  = AboutUsController()
            //controller.view.backgroundColor  = .yellow
            self.present(controller, animated: true, completion: nil)
     
            
        case .some(.Version):
            return
        }
        
    }
    
    //Animation for status bar
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool{
        return isExpanded
    }
    
    
    private func animateStatusBar(){
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.setNeedsStatusBarAppearanceUpdate()
        } completion: { (_) in
            return
        }
        
    }
}



extension ContainerController : MenuToggleProtocol{
    func handleToggle(settingItem: SettingsV2?){
        if !isExpanded{
            loadMenu()
        }
        isExpanded =  !isExpanded
        animateMenu(shouldExpand: isExpanded, settingOption: settingItem)
    }
}
//extension ContainerController :  NoInternetProtocol{
//    func changedValue() {
//        print("Network changes")
//
//        DispatchQueue.main.async {
//
//            if NetworkMonitor.shared.isConnected{
//                self.loadNoInternetConnnection()
//                self.animateNoInternet(internetConnection: false)
//
//            }else {
//                self.animateNoInternet(internetConnection: true)
//
//            }
//
//        }
//      
//    }
//    
//    //Load the menu only once,single instance
//    private func loadNoInternetConnnection(){
//        if internetConnectionController == nil{
//            internetConnectionController =  NoInternetConnection()
//            //menuController.delegate = self
//            //view.insertSubview(menuController.view, aboveSubview: centerController.view)
//            self.internetConnectionController.view.frame.origin.y =  self.internetConnectionController.view.frame.height
//            //self.menuController.view.frame.size.width = self.centerController.view.frame.width - 56
//            //self.internetConnectionController.view.alpha =  0.5
//            view.insertSubview(internetConnectionController.view, at: 1)
//            addChild(internetConnectionController)
//            internetConnectionController.didMove(toParent: self)
//            
//        }
//    }
//    
//    
//    private func animateNoInternet (internetConnection : Bool){ 
//        if internetConnection{
//            //Show menu
//            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
//                self.internetConnectionController.view.frame.origin.y =  0
//            }, completion :nil)
//            
//        }else {
//            
//            //Hide menu
//            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn) {
//                self.internetConnectionController.view.frame.origin.y = self.internetConnectionController.view.frame.height
//                //self.internetConnectionController.view.removeFromSuperview()
//            } completion: { (_) in
//               return
//            }
//            
//        }
//        //animateStatusBar()
//    }
//    
//}
//
//
//

