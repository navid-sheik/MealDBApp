//
//  TabController.swift
//  FoodDB
//
//  Created by Navid Sheikh on 07/08/2021.
//

import Foundation
import UIKit


class MealTabController  :  UITabBarController{
    
    weak var delegateToggle  : MenuToggleProtocol?
    var mainController : MainController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        
        tabBar.tintColor =  .darkGray
        tabBar.isTranslucent = false
        
        //Main controller - First Controller
        let itemControllerItem1  =  UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        mainController  = MainController()
        mainController.delegateToggle =  delegateToggle
        let controller1 =  UINavigationController(rootViewController: mainController)
        controller1.tabBarItem = itemControllerItem1
        
        //Area controller - Second Controller
        let itemControllerItem2  =  UITabBarItem(title: "Country", image: UIImage(systemName: "flag"), tag: 1)
        let rootController2 =  AreaTableController(style: .plain)
        let controller2   = UINavigationController(rootViewController: rootController2)
        controller2.tabBarItem = itemControllerItem2

        //Category controller - Third Controller
        let itemControllerItem3  =  UITabBarItem(title: "Category", image: UIImage(systemName: "list.bullet"), tag: 2)
        let rootController3 =  CategoryController()
        let controller3   = UINavigationController(rootViewController: rootController3)
        controller3.tabBarItem = itemControllerItem3
        
        //AtoZ controller - Fourth Controller
        let itemControllerItem4  = UITabBarItem(title: "Letter", image: UIImage(systemName: "textformat"), tag: 3)
        let rootController4 =  AtoZController()
        let controller4  = UINavigationController(rootViewController: rootController4)
        controller4.tabBarItem = itemControllerItem4
        
        //Tag controller - Fifth Controller
        let itemControllerItem5 = UITabBarItem(title: "Ingredients", image: UIImage(systemName: "tag"), tag: 4)
        let layout  =  UICollectionViewFlowLayout()
        let rootController5 =  TagController()
        let controller5  = UINavigationController(rootViewController: rootController5)
        controller5.tabBarItem = itemControllerItem5
        
        //Assign controllers
        viewControllers =  [controller1,controller2, controller3, controller4, controller5]
    }
    
    
    //Solve problem of assigning the delegate
    func resetDelegate (){
        mainController.delegateToggle = self
    }
    
    //MARK: ACTIONS OBJC
    @objc func expandMenu (){
        print ("Expand the menu right now")
        delegateToggle?.handleToggle(settingItem: nil)
    }
    
    
    //Optional
//    private func setNavigationController (){
//        navigationItem.title =  "HOME"
//        //navigationController?.navigationBar.prefersLargeTitles = true
//
//        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.barStyle = .default
//        navigationController?.navigationBar.barTintColor = .gray
//        navigationController?.navigationBar.backgroundColor =  .darkGray
//        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
//        let leftBarButton =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(expandMenu))
//        navigationItem.leftBarButtonItem = leftBarButton
//    }

}



extension MealTabController : MenuToggleProtocol{
    func handleToggle(settingItem: SettingsV2?) {
        delegateToggle?.handleToggle(settingItem: settingItem)
    }
}


