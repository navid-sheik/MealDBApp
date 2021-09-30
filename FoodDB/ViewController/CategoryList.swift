//
//  IndividualCategoryList.swift
//  FoodDB
//
//  Created by Navid Sheikh on 15/07/2021.
//

import Foundation
import UIKit


class CategoryList: UIViewController {
    
    
    var categoryName : String
    var category : Category? {
        didSet{
            self.navigationItem.title =  self.category?.category
        }
    }
    
    let identifier :  String =  "categoryList"
    let headerIdentifier2 : String =  "header1ffsf"
    
    //For collection view inside
    var categoryArray : [CategoryListIndividual]?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    let collectionView:  UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    init(categoryName : String) {
        self.categoryName = categoryName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpViews()
        fetchDataForCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.layer.zPosition = -1
        //tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.layer.zPosition = 0
        //tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpViews(){
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leadingAnchor, right:  view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    }
    
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MealInListCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.register(Headercategory.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier2)
    }
    
    private func fetchDataForCategory(){
        MealService.shared.getIndividualListCategory(with: categoryName) { [weak self]  (result) in
            guard let self = self else { return }
            switch result{
            case .success(let allListCategory):
                DispatchQueue.main.async {
                    self.categoryArray = allListCategory
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                fatalError("There is some kind error during api call  \(error)")
            }
        }
    }
}

extension  CategoryList :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let headerView  =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier2, for: indexPath) as! Headercategory
            if let categoryI = category{
                headerView.individualCategory = category
                headerView.delegate = self
            }
            return headerView
        }
        fatalError("Somethign")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: 325)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let listCategories = categoryArray  {
            return listCategories.count
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MealInListCell
        if let  arrayCategoryList =  categoryArray {
            cell.categoryListView = arrayCategoryList[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 2 ) / 3, height:  (collectionView.frame.width - 2) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let mealId =  categoryArray?[indexPath.row].idMeal else {
            return
        }
        let controller  =  MealViewController(idMeal: mealId)
        present(controller, animated: true, completion: nil)
    }
    
}

extension CategoryList : ReloadHeaderDelegate{
    func reloadCollectioView() {
        self.collectionView.reloadData()
    }
}
