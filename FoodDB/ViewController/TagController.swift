//
//  TagController.swift
//  FoodDB
//
//  Created by Navid Sheikh on 26/07/2021.
//

import Foundation
import UIKit



class TagController: UICollectionViewController{
    
    let identifier : String  =  "tagIdentifierCell"
    var tags = [Ingredient]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor =  .white
        collectionView.delegate = self
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: identifier)
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
        let ingredientsURL  = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
        MealService.shared.getAllIngridient(with: ingredientsURL) { (result) in
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


extension TagController  : UICollectionViewDelegateFlowLayout{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let ingredientName = tags[indexPath.row].strIngredient else {
            return
        }
        let controller  = SingleIngredientController(ingredientName:  ingredientName)
        controller.ingredient =  tags[indexPath.row]
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
        
        
    }
}
