//
//  AtoZController.swift
//  FoodDB
//
//  Created by Navid Sheikh on 24/07/2021.
//

import Foundation
import UIKit



class AtoZController : UIViewController{
    
    
    var currentLetter : String =  "A"
    let letters  =  ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    let identifierLetter :  String =  "aTozCellColletionview"
    let  identifierContent : String  = "identifierCellAtoZ"
    
    var mealsFilteredByLetter :  [Meal]?
    
    
    var colletionView :  UICollectionView  = {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv  = UICollectionView (frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.alwaysBounceHorizontal = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    var mainTableView :  UITableView  = {
        let tableView  =    UITableView()
        tableView.backgroundColor =  .white
        tableView.rowHeight = 100
        tableView.backgroundColor = .white
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView =  UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpCollectionViewLetters()
        setUpContentTableView()
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
    
    private func  setUpCollectionViewLetters (){
        view.addSubview(colletionView)
        colletionView.register(LetterCell.self, forCellWithReuseIdentifier: identifierLetter)
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: nil, width: nil, height: 30)
        
    }
    
    private func setUpContentTableView(){
        mainTableView.dataSource = self
        mainTableView.delegate  = self
        view.addSubview(mainTableView)
        mainTableView.register(PreviewCellAtoZ.self, forCellReuseIdentifier: identifierContent)
        mainTableView.anchor(top: colletionView.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    }
    
}


extension AtoZController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return letters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: identifierLetter, for: indexPath) as! LetterCell
        cell.label.text = letters[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        currentLetter = letters[indexPath.row]
        fetchData()
    }
    
    private func fetchData(){
        MealService.shared.getIndividualListLetter(with: currentLetter) { (result) in
            switch result{
            
            case .success(let listLetter):
                self.mealsFilteredByLetter =  listLetter
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            case .failure(let error):
                self.mealsFilteredByLetter =  []
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
                print("Error fetching letter \(error)")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let mealId =  mealsFilteredByLetter?[indexPath.row].idMeal else {
            return
        }
        let controller  =  MealViewController(idMeal: mealId)
        present(controller, animated: true, completion: nil)
    }
}



extension AtoZController :  UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let  mealsFilteredByLetter =  mealsFilteredByLetter {
            return  mealsFilteredByLetter.count
        }
        return  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierContent, for: indexPath) as! PreviewCellAtoZ
        if let  mealsFilteredByLetter =  mealsFilteredByLetter {
            if let imageUrl =  mealsFilteredByLetter[indexPath.row].strMealThumb{
                cell.previewImageView.loadImageUrlString(urlString: imageUrl)
                cell.titleMeal.text = mealsFilteredByLetter[indexPath.row].strMeal
            }
        }
        cell.selectionStyle =  .none
        return cell
        
    }
}
