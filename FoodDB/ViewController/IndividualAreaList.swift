//
//  IndividualAreaList.swift
//  FoodDB
//
//  Created by Navid Sheikh on 24/07/2021.
//

import Foundation
import UIKit

class IndividualAreaList: UIViewController {
    
    var areaFood : String
    
    var areaListPreview : [CategoryListIndividual]?{
        didSet{
            print("Soemthi")
            //self.colletionView.reloadData()
        }
    }
        
    let collectionIdentifier : String = "areaIdentifier"
    
    let colletionView =  UICollectionView(frame: .zero, collectionViewLayout: IndividualAreaList.createLayout())
    
    
    
    init(areaFood : String) {
        self.areaFood = areaFood
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpNavigation()
        hidesBottomBarWhenPushed  = true

        navigationItem.title =  areaFood
        setUpCollectionView()
        fetchData()

    }
    
    
    private func setUpCollectionView (){
        colletionView.backgroundColor =  .white
        colletionView.register(MealInListCell.self, forCellWithReuseIdentifier: collectionIdentifier)
        view.addSubview(colletionView)
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.anchor(top: view.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout{
        let inset  : CGFloat =  2
        
        //Small Items
        let smallItemGeneral  = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
        
        smallItemGeneral.contentInsets.trailing = inset

        
        let generalGroup =  NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/5)), subitems: [smallItemGeneral])

        generalGroup.contentInsets.leading = inset
        
        generalGroup.contentInsets.bottom = inset
        
        
        //Large Item + 2 small cell side
        
        
        let smallItem  = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)))
        smallItem.contentInsets.bottom =  inset
        
        let singleItem  = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let singleGroup   =  NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1)), subitem: singleItem, count: 1)
        
        singleGroup.contentInsets.leading =  inset
        
        singleGroup.contentInsets.trailing =  inset
        singleGroup.contentInsets.bottom =  inset
        
        let smallItemGroup  =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)), subitems: [smallItem])
        smallItemGroup.contentInsets.trailing =  inset
        
        
        
        let largeGroup  = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(3/5)), subitems: [singleGroup, smallItemGroup])
        
        
        //
        
        let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/5)), subitems: [generalGroup, largeGroup])
        
        
        
        
        
        
        
//        //item
//        let item  = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//
//        //group
//        let group  =   NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/5)), subitem: item, count: 2)
//
//        //sections
        
        
        let section =  NSCollectionLayoutSection(group: containerGroup)
    
        //return

        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    private func setUpNavigation(){
        navigationItem.title =  "Something"
    }
    
    
    
    private func fetchData(){
        MealService.shared.getIndividualListArea(with: areaFood) { (result) in
            switch result{
            
            case .success(let mealForAreaPreview):
                self.areaListPreview  = mealForAreaPreview
                DispatchQueue.main.async {
                    self.colletionView.reloadData()
                }
          
            case .failure(let error):
                print("There is an error while fetching area meals  \(error)")
            }
        }
    }
    
    
}

extension  IndividualAreaList : UICollectionViewDelegate, UICollectionViewDataSource{

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let areaListPreview  = areaListPreview {
            return areaListPreview.count
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionIdentifier, for: indexPath) as! MealInListCell
        
        
        if let areaListPreview  = areaListPreview {
            cell.categoryListView = areaListPreview[indexPath.row]
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let mealId =  areaListPreview?[indexPath.row].idMeal else {
            return
        }
        let controller  =  MealViewController(idMeal: mealId)
        present(controller, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.layer.zPosition = -1
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.layer.zPosition = 0
    }
}

