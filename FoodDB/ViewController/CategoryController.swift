//
//  ViewController.swift
//  FoodDB
//
//  Created by Navid Sheikh on 13/07/2021.
//

import UIKit

class CategoryController : UIViewController {
    
    let identifier : String =  "categoryCell"
    var categories = [Category]()
    let collectionView :  UICollectionView = {
        let flowLayout =  UICollectionViewFlowLayout()
        flowLayout.scrollDirection =  .vertical
        let cv =  UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor  = .clear
        return cv
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor =  .white
        setNavigationController()
        setUpColletionView()
        fetchData()
    }
    
    private func setNavigationController (){
        navigationItem.title =  "Category"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func setUpColletionView (){
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: identifier)
    }
    
    private func fetchData(){
        //let categoryUrl = "https://www.themealdb.com/api/json/v1/1/categories.php"
        let results  =  MealService.shared.getAllCategories() { (result) in
            switch result{
            case .success(let categoryColletions):
                self.categories =  categoryColletions
                DispatchQueue.main.async {
                    
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Failed somethign\(error)")
            }
        }
    }
    
}

extension CategoryController :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CategoryCell
        cell.individualCategory =  categories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 46) / 2 , height: (collectionView.frame.width - 16) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let categoryNameToPass  =  categories[indexPath.row].category else {
            return
        }
        let controller =  CategoryList(categoryName: categoryNameToPass)
        controller.category = categories[indexPath.row]
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
}

