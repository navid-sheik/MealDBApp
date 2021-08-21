//
//  MealViewController.swift
//  FoodDB
//
//  Created by Navid Sheikh on 26/07/2021.
//

import Foundation
import UIKit
import youtube_ios_player_helper

class MealViewController : UIViewController, YTPlayerViewDelegate{
    
    var idMeal : String
    var tagsArrrayDisplay  =  [String]()
    var dict =  [Int : (String? , String?)]()
    
    //Scrollview
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints  = false
        return scrollView
    }()
    
    let contentView : UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleMeal : UILabel =  {
        let label =  UILabel ()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text  = "Meal Title"
        label.textAlignment =  .left
        label.textColor = .black
        return label
    }()
    
    let mealImageView : CustomImageView = {
        let imageView  =  CustomImageView()
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor =  .systemGray
        imageView.image =  UIImage(named: "placeholder")
        return imageView
    }()
    
    let player : YTPlayerView = {
        let player  = YTPlayerView()
        player.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    
    let instructionsLabel :  UILabel =  {
        let label =  UILabel ()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text  = "Meal Title"
        label.textAlignment =  .left
        label.textColor = .black
        label.numberOfLines =  0
        label.textAlignment =  .natural
        label.sizeToFit()
        return label
    }()
    
    let tagLabel  : UILabel = {
        let label = UILabel ()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text  = "Meal Title"
        label.textAlignment =  .left
        label.textColor = .black
        label.backgroundColor = .blue
        return label
    }()
    
    let tagStackView : UIStackView =  {
        let stackview =  UIStackView()
        stackview.axis =  .horizontal
        stackview.distribution = .equalSpacing
        stackview.alignment = .center
        stackview.spacing =  20
        return stackview
    }()
    
    let measurementsAndIngridientsSV : UIStackView =  {
        let stackview =  UIStackView()
        stackview.backgroundColor = .white
        stackview.axis =  .vertical
        stackview.distribution = .equalSpacing
        stackview.alignment = .leading
        stackview.spacing =  2
        return stackview
    }()
    
    
    lazy var tagsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    init(idMeal  : String) {
        self.idMeal =  idMeal
        super.init(nibName: nil, bundle: nil)
        fetchMealDetails()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .white
        setUpNavigationBar()
        setUpLayout()
    }
    
    private func setUpNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.title = "Meal"
    }
    
    private func setUpLayout (){
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor).isActive = true
        
        contentView.addSubview(titleMeal)
        titleMeal.anchor(top: contentView.topAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5, paddingRight: -5, paddingBottom: nil, width: nil, height: 50)
        
        contentView.addSubview(mealImageView)
        mealImageView.anchor(top: titleMeal.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: nil, width: nil, height: 250)
        
        contentView.addSubview(instructionsLabel)
        instructionsLabel.anchor(top: mealImageView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5, paddingRight: -5, paddingBottom: nil, width: nil, height: nil)
        
        contentView.addSubview(tagsScrollView)
        tagsScrollView.anchor(top: instructionsLabel.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5, paddingRight: 5, paddingBottom: nil, width: nil, height: 50)
        
        tagsScrollView.addSubview(tagStackView)
        tagStackView.translatesAutoresizingMaskIntoConstraints = false
        tagStackView.topAnchor.constraint(equalTo: tagsScrollView.topAnchor).isActive = true
        tagStackView.leadingAnchor.constraint(equalTo: tagsScrollView.leadingAnchor).isActive = true
        tagStackView.trailingAnchor.constraint(equalTo: tagsScrollView.trailingAnchor).isActive = true
        tagStackView.heightAnchor.constraint(equalTo: tagsScrollView.heightAnchor).isActive = true
        
        contentView.addSubview(measurementsAndIngridientsSV)
        //key of scrollview for scrolling
        measurementsAndIngridientsSV.anchor(top: tagsScrollView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5, paddingRight: -5, paddingBottom: nil, width: nil, height: nil)
        
        contentView.addSubview(player)
        player.delegate  = self
        player.anchor(top: measurementsAndIngridientsSV.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor, paddingTop: 30, paddingLeft: 5, paddingRight: -5, paddingBottom: -200, width: nil, height: 200)
        player.load(withVideoId: "3lxUIeKDgic", playerVars: ["playsinline" : 1])
    }
    
    func populateTagsStackView(){
        for nValue in 0...tagsArrrayDisplay.count - 1 {
            let label: UILabel = UILabel()
            
            label.text = tagsArrrayDisplay[nValue]
            label.textColor = .white
            label.backgroundColor = .black
            label.font =  UIFont.boldSystemFont(ofSize: 16)
            tagStackView.addArrangedSubview(label)
        }
    }
    
    
    func populateMeasurementsStackView(){
        for nValue in 1...dict.count {
            if let valueString  =  dict[nValue]?.0 {
                if valueString != ""{
                    let label: UILabel = UILabel()
                    label.textColor = .black
                    label.text = "\u{2022} \(dict[nValue]!.0!) - \(dict[nValue]!.1!)"
                    measurementsAndIngridientsSV.addArrangedSubview(label)
                }
            }
        }
    }
    
    private func fetchMealDetails(){
        let urlString  = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)"
        MealService.shared.getIndividualMeals(with: urlString) { (result) in
            switch result{
            case .success(let meals):
                DispatchQueue.main.async {
                    self.titleMeal.text =  meals[0].strMeal
                    self.mealImageView.loadImageUrlString(urlString: meals[0].strMealThumb!)
                    self.instructionsLabel.text =  meals[0].strInstructions
                    self.populateDictonary(meal: meals[0])
                    self.populateMeasurementsStackView()
                    self.organizeTags(meal: meals[0])
                    self.populateTagsStackView()
                    if  let stringYoutuber  = meals[0].strYoutube?.youtubeID{
                        self.player.load(withVideoId: stringYoutuber, playerVars: ["playsinline" : 1])
                    }
                }
            case .failure(let error):
                print("Error\(error)")
            }
        }
    }
    
    private func organizeTags(meal : Meal){
        var tagToUse =  [String]()
        if let stringTags = meal.strTags{
            tagToUse = stringTags.components(separatedBy: ",")
            tagsArrrayDisplay.append(contentsOf: tagToUse)
        }
        if  let category =  meal.strCategory{
            tagsArrrayDisplay.append(category)
        }
        if let  area = meal.strArea{
            tagsArrrayDisplay.append(area)
        }
    }
    
    private func createLabel (name : String, bgcolor : UIColor) -> UILabel{
        let label  = UILabel()
        label.text =  name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor  =  bgcolor
        label.font  = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment =  .center
        return label
    }
    
    private func populateDictonary(meal : Meal){
        dict[1] =  (meal.strIngredient1, meal.strMeasure1)
        dict[2] =  (meal.strIngredient2, meal.strMeasure2)
        dict[3] =  (meal.strIngredient3, meal.strMeasure3)
        dict[4] =  (meal.strIngredient4, meal.strMeasure4)
        dict[5] =  (meal.strIngredient5, meal.strMeasure5)
        dict[6] =  (meal.strIngredient6, meal.strMeasure6)
        dict[7] =  (meal.strIngredient7, meal.strMeasure7)
        dict[8] =  (meal.strIngredient8, meal.strMeasure8)
        dict[9] =  (meal.strIngredient9, meal.strMeasure9)
        dict[10] =  (meal.strIngredient10, meal.strMeasure10)
        dict[11] =  (meal.strIngredient11, meal.strMeasure11)
        dict[12] =  (meal.strIngredient12, meal.strMeasure12)
        dict[13] =  (meal.strIngredient13, meal.strMeasure13)
        dict[14] =  (meal.strIngredient14, meal.strMeasure14)
        dict[15] =  (meal.strIngredient15, meal.strMeasure15)
        dict[16] =  (meal.strIngredient16, meal.strMeasure16)
        dict[17] =  (meal.strIngredient17, meal.strMeasure17)
        dict[18] =  (meal.strIngredient18, meal.strMeasure18)
        dict[19] =  (meal.strIngredient19, meal.strMeasure19)
        dict[20] =  (meal.strIngredient20, meal.strMeasure20)
    }
    
}
