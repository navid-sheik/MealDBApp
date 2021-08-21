//
//  TabController.swift
//  FoodDB
//
//  Created by Navid Sheikh on 07/08/2021.
//

import Foundation
import UIKit


class MealTabController  :  UITabBarController, MenuToggleProtocol{
    func handleToggle(settingItem: Settings?) {
        delegateToggle?.handleToggle(settingItem: settingItem)
    }
    
  
    
    
    var delegateToggle  : MenuToggleProtocol?
    
    
    var mainController : MainController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor =  .darkGray
        tabBar.isTranslucent = false
       
        //setNavigationController()
        let itemControllerItem1  =  UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
    
        mainController  = MainController()
        mainController.delegateToggle =  delegateToggle
        
        let controller1 =  UINavigationController(rootViewController: mainController)
        //controller1.view.backgroundColor =  .white
        
        controller1.tabBarItem = itemControllerItem1
        
        
        
        let itemControllerItem2  =  UITabBarItem(title: "Country", image: UIImage(systemName: "flag"), tag: 1)
        let rootController2 =  AreaTableController(style: .plain)
        let controller2   = UINavigationController(rootViewController: rootController2)
       // controller2.view.backgroundColor =  .blue
        controller2.tabBarItem = itemControllerItem2
        
        
        
        let itemControllerItem3  =  UITabBarItem(title: "Category", image: UIImage(systemName: "list.bullet"), tag: 2)
        let rootController3 =  CategoryController()
        let controller3   = UINavigationController(rootViewController: rootController3)
       // controller2.view.backgroundColor =  .blue
        
        controller3.tabBarItem = itemControllerItem3
        
        
        
        let itemControllerItem4  = UITabBarItem(title: "Letter", image: UIImage(systemName: "textformat"), tag: 3)
        let rootController4 =  AtoZController()
        let controller4  = UINavigationController(rootViewController: rootController4)

       // controller2.view.backgroundColor =  .blue
        
        controller4.tabBarItem = itemControllerItem4
        
        
        
        let itemControllerItem5 = UITabBarItem(title: "Tags", image: UIImage(systemName: "tag"), tag: 4)
        let layout  =  UICollectionViewFlowLayout()
        let rootController5 =  TagController(collectionViewLayout: layout)
        let controller5  = UINavigationController(rootViewController: rootController5)
  
       // controller2.view.backgroundColor = .blue
        
        controller5.tabBarItem = itemControllerItem5
        
        
        viewControllers =  [controller1,controller2, controller3, controller4, controller5]
        
        //if controller = self.viewControllers![0] as! MainController
        
    }
    
    
    func resetDelegate (){
      
            mainController.delegateToggle = self
        
    }
    private func setNavigationController (){
        navigationItem.title =  "HOME"
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .gray
        navigationController?.navigationBar.backgroundColor =  .darkGray
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        let leftBarButton =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(expandMenu))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    
    //MARK: ACTIONS OBJC
    @objc func expandMenu (){
        print ("Expand the menu right now")
        delegateToggle?.handleToggle(settingItem: nil)
    }
    
    
}



