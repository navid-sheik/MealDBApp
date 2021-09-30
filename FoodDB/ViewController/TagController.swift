//
//  TagController.swift
//  FoodDB
//
//  Created by Navid Sheikh on 26/07/2021.
//

import Foundation
import UIKit



class TagController: UIViewController{
    
    var collectionView :  UICollectionView  = {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv  = UICollectionView (frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.alwaysBounceHorizontal = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    
    
    let identifier : String  =  "tagIdentifierCell"
    var tags = [Ingredient]()
    var hideStatusBar: Bool  =  false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.edgesForExtendedLayout = []
        collectionView.backgroundColor =  .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: identifier)
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        fetchData()
    
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setNavigationBar(){
        navigationController?.navigationBar.isHidden = true
    }
    
    
    private func fetchData(){
        //let ingredientsURL  = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
        MealService.shared.getAllIngridient() { [weak self] (result) in
            guard let self = self else { return }
            switch result{
            case .success(let ingridientList):
                self.tags = ingridientList
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("There is error\(error) ")
            }
        }
    }
}


extension TagController  : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TagCell
        if tags.count != 0 {
            if let ingredientName = tags[indexPath.row].strIngredient  {
                cell.tagName.text = ingredientName
            }
        }
        
        cell.backgroundColor = .darkGray
        cell.contentView.layer.cornerRadius =  4.0
        cell.contentView.layer.borderWidth =  1.0
        cell.contentView.layer.borderColor =  UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor =  UIColor.black.cgColor
        cell.layer.shadowOffset =  CGSize(width: 0, height: 3.0)
        cell.layer.shadowRadius =  2.0
        cell.layer.shadowOpacity =  0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item =  tags[indexPath.row]
        if let ingredientName  = item.strIngredient  {
            let stringWidth = ingredientName.size(withAttributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]).width + 6
            return CGSize(width: stringWidth, height: 20)
        }
        return  CGSize(width: 100, height: 100)
        
    }
    
    //vertical
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    //horizontal
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let ingredientName = tags[indexPath.row].strIngredient else {
            return
        }
        let controller  = SingleIngredientController(ingredientName:  ingredientName)
        controller.ingredient =  tags[indexPath.row]
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
    
//    //Animation for status bar
//    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
//        return .slide
//    }
//    
//    override var prefersStatusBarHidden: Bool{
//        //return isExpanded
//        return hideStatusBar
//    }
//    
//    
//    private func animateStatusBar(){
//        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
//            self.setNeedsStatusBarAppearanceUpdate()
//        } completion: { (_) in
//            return
//        }
//        
//    }
//    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        hideStatusBar =  true
//        self.animateStatusBar()
//    }
//    
//    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        hideStatusBar = false
//        self.animateStatusBar()
//    }
    //Figure out how to hide scroll bar
    
//
//    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        if targetContentOffset.pointee.y >= 0 {
//            animateStatusBar()
//        }
//        else{
//            animateStatusBar()
//        }
//    }
//    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
//        //dragging down
//        hideStatusBar = true
//        if (actualPosition.y > 0){
//
//            animateStatusBar()
//        }
//        else {
//            //dragging up
//        }
//    }
}
