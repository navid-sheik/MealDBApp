//
//  SingleIngredientCotroller.swift
//  FoodDB
//
//  Created by Navid Sheikh on 27/07/2021.
//

import Foundation
import UIKit

class SingleIngredientController : UIViewController{
    
    
    
  
    var noMessageView : NoResultMessage = {
        let view  =  NoResultMessage()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    
    
    var ingredientName: String
    var identifierPreviewIngridient : String =  "identifierPreviewIngridientCell"
    var listMealsByIngredientsPreview : [CategoryListIndividual]?
    var ingredient : Ingredient?{
        didSet{
            guard let ingridient  =  ingredient else {
                return
            }
            titleIngredient.text = ingredient?.strIngredient
            if  let ingredientDescription  =  ingredient?.strDescription {
                descriptionINgridient.text =  ingredientDescription
            }else {
//                descriptionINgridient.isHidden = true
//                descriptionScrollView.isHidden = true
                descriptionScrollView.heightAnchor.constraint(equalToConstant: 0).isActive =  true
            }
           
 
        }
    }
    
    var titleIngredient : UILabel = {
        let label = UILabel ()
        label.text = "tag"
        label.sizeToFit()
        label.font =  UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var imageIngredient :  UIImageView =  {
        let imageView  =  UIImageView()
        imageView.contentMode  = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let descriptionScrollView :  UIScrollView =  {
        let sv =  UIScrollView()
        return sv
    }()
    
    let contentView : UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var descriptionINgridient: UILabel = {
        let label = UILabel ()
        label.text = ""
        label.sizeToFit()
        label.font =  UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let colletionView =  UICollectionView(frame: .zero, collectionViewLayout: SingleIngredientController.createLayout())
    
    static func createLayout ()-> UICollectionViewCompositionalLayout{
        //item
        let item =  NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        //group
        let group  = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/5
        )), subitem: item, count: 2)
        
        //section
        let section =  NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    
    init(ingredientName : String) {
        self.ingredientName =  ingredientName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .white
        navigationController?.navigationBar.isHidden = true
        setUpViews()
        setUpCollectionView()
        fetchData()
        
    }
    
    private func setUpViews(){
        view.addSubview(titleIngredient)
        view.addSubview(descriptionScrollView)
        view.addSubview(colletionView)
        view.addSubview(noMessageView)
        
        titleIngredient.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5, paddingRight: -5, paddingBottom: nil, width: nil, height: nil)
        
        descriptionScrollView.addSubview(contentView)
        descriptionScrollView.translatesAutoresizingMaskIntoConstraints = false
        descriptionScrollView.topAnchor.constraint(equalTo: titleIngredient.bottomAnchor, constant: 5).isActive = true
        descriptionScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        descriptionScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        descriptionScrollView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: descriptionScrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: descriptionScrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: descriptionScrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: descriptionScrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: descriptionScrollView.widthAnchor).isActive = true
        
        contentView.addSubview(descriptionINgridient)
        descriptionINgridient.anchor(top: descriptionScrollView.topAnchor, left: descriptionScrollView.leadingAnchor, right: descriptionScrollView.trailingAnchor, bottom: descriptionScrollView.bottomAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: -20, width: nil, height: nil)
        descriptionINgridient.widthAnchor.constraint(equalTo: descriptionScrollView.widthAnchor).isActive = true
        
        
        
        colletionView.anchor(top: descriptionScrollView.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        noMessageView.anchor(top: descriptionScrollView.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
       
        
    }
    
    
    private func setUpCollectionView(){
        colletionView.backgroundColor  = .white
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.register(MealInListCell.self, forCellWithReuseIdentifier: identifierPreviewIngridient)
    }
    
    private func fetchData(){
        //remove space between two words because of the api call
        var ingredientToPass : String = ""
        let fullIngredientArray =  ingredientName.components(separatedBy: " ")
        if fullIngredientArray.count > 1{
            for index in 0...fullIngredientArray.count - 1 {
                if index == fullIngredientArray.count - 1{
                    ingredientToPass += fullIngredientArray[index]
                }else{
                    ingredientToPass += fullIngredientArray[index] + "_"
                }
            }
        }else{
            ingredientToPass =  fullIngredientArray[0]
        }
        MealService.shared.getIndividualListIngredient(with: ingredientToPass) { [weak self] (result) in
            guard let self = self else { return }
            switch result{
            
            case .success(let mealForIngredientPreview):
                self.listMealsByIngredientsPreview  = mealForIngredientPreview
                DispatchQueue.main.async {
                    self.colletionView.isHidden = false
                    self.noMessageView.isHidden = true
                    self.colletionView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.colletionView.isHidden = true
                    self.noMessageView.isHidden = false
                }
                print("There is an error while fetching area meals  \(error)")
            }
        }
    }
}

extension SingleIngredientController :  UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let mealListIngridientPreiews  =  listMealsByIngredientsPreview {
            return mealListIngridientPreiews.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierPreviewIngridient, for: indexPath)  as! MealInListCell
        if let mealListIngridientPreiews  =  listMealsByIngredientsPreview {
            if let imageUrl =  mealListIngridientPreiews[indexPath.row].strMealThumb {
                cell.categoryImageView.loadImageUrlString(urlString: imageUrl)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let mealId =  listMealsByIngredientsPreview?[indexPath.row].idMeal else {
            return
        }
        let controller  =  MealViewController(idMeal: mealId)
        present(controller, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.layer.zPosition = -1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.layer.zPosition = 0
    }
}

