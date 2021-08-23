//
//  MainController.swift
//  FoodDB
//
//  Created by Navid Sheikh on 03/08/2021.
//

import Foundation
import UIKit

class MainController : UIViewController{
    
    
    var delegateToggle  : MenuToggleProtocol!
    private let  cellIdentifierMain : String =  "cellIdentifierMain"
    
    var bannerImagesNames  =  ["food0", "food1", "food2", "food3"]
    var bannerIdentifierCell  : String =  "bannerIdentifierCell"
    
    var featuredIngredients   = [Ingredient]()
    var featuredIngridientCell  : String =  "featuredIngridientCell"
    
    var featuredAreas   = [AreaFood]()
    var featuredAreaCellIdentifier : String =  "featuredAreaCell"
    
    var featuredCategories =   [Category]()
    var featuredCategoryIdentifierCell =  "featuredCategoryIdentifierCell"
    
    var featuredRandomMeals =  [Meal]()
    var featuredMealIdentifierCell =  "featuredMealIdentifierCell"
    
    
    
    var latestMeals  =  [Meal]()
    var latestMealIdentifierCell =  "latestMealIdentifierCell"
    
    
    //For Headers in collectionsViews
    static let categoryHeaderId =  "categoryHeaderId"
    static let featuredHeaderId =  "featuredHeaderId"
    private let headerId  =  "headerId"
    private let featureId   =  "featureId"
    
    private var timer : Timer?
    private var counter  = 0
    
    
    
    let collectionView : UICollectionView = {
        let cv  =  UICollectionView(frame: .zero, collectionViewLayout: MainController.createLayout())
        cv.backgroundColor  = .white
        return cv
    }()
    
    
    let navigationViewBar : CustomMenuBar =  {
        let view  = CustomMenuBar()
        return view
    }()
    
    
    static func createLayout() -> UICollectionViewCompositionalLayout{
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let group  =  NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                
                let  section  = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 10
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.bottom = 25
                return section
                
                
            }else if sectionNumber == 1{
                
                let item =  NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1)))
                item.contentInsets.leading = 16
                
                let group  = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35)), subitems: [item])
                group.contentInsets.trailing =  16
                
                let section  = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior =  .continuous
                section.contentInsets.bottom = 25
                
                return section
                
            }else if sectionNumber == 2{
                
                let item =  NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                
                let group  = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                group.contentInsets.trailing =  16
                
                let section  = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior =  .paging
                
                section.contentInsets.leading = 16
                section.boundarySupplementaryItems =  [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: MainController.categoryHeaderId, alignment: .topLeading)]
                
                section.contentInsets.bottom = 25
                return section
                
                
            }else if sectionNumber == 3{
                
                let item =  NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1)))
                item.contentInsets.leading = 16
                
                let group  = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35)), subitems: [item])
                group.contentInsets.trailing =  16
                
                let section  = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior =  .continuous
                section.contentInsets.bottom = 30
                return section
            }
            
            else if sectionNumber  == 4{
                
                let  item =  NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.50), heightDimension: .fractionalWidth(0.50)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
                
                let group =  NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                
                let section  =  NSCollectionLayoutSection(group: group)
                
                section.contentInsets.leading =  16
                section.boundarySupplementaryItems =  [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: MainController.categoryHeaderId, alignment: .topLeading)]
                return section
            }else {
                
                let item =  NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                
                let group  = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                group.contentInsets.trailing =  16
                
                let section  = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior =  .paging
                
                section.contentInsets.leading = 16
                section.boundarySupplementaryItems =  [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: MainController.categoryHeaderId, alignment: .topLeading)]
                
                section.contentInsets.bottom = 25
                return section
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setCustomNavigationbar()
        setUpCollectionView()
        fetchFeaturedTags()
        featchFeatureArea()
        fetchFeaturedCategories()
        //feathThreeRandomMeals()
        fetchFeatured10Meals()
        fetchLatestMeals()
        DispatchQueue.main.async {
            self.timer =  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
     
    }
    
    
    func startTimer()
    {
      if timer == nil {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
      }
    }

    func stopTimer()
    {
      if timer != nil {
        timer!.invalidate()
        timer = nil
      }
    }
 
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let  offset =  targetContentOffset.pointee.y
        if offset < 200{
            startTimer()
        }else {
            stopTimer()
        }
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //Set navigation bar hide
    private func setNavigationBar(){
        navigationController?.navigationBar.isHidden = true
    }
    
    //Custom navigation with menu button
    private func setCustomNavigationbar(){
        navigationViewBar.buttonBarItem.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)
        view.addSubview(navigationViewBar)
        navigationViewBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: 50)
    }

    private func setUpCollectionView(){
        collectionView.backgroundColor =  .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifierMain)
        collectionView.register(Header.self, forSupplementaryViewOfKind: MainController.categoryHeaderId, withReuseIdentifier: headerId)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: bannerIdentifierCell)
        collectionView.register(FeaturedTextCell.self, forCellWithReuseIdentifier: featuredIngridientCell)
        collectionView.register(FeaturedTextCell.self, forCellWithReuseIdentifier: featuredAreaCellIdentifier)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: featuredCategoryIdentifierCell)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: featuredMealIdentifierCell)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: latestMealIdentifierCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.anchor(top: navigationViewBar.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: -20, width: nil, height: nil)
    }
    
    //Menu delegate for menu
    @objc func handleMenu(){
        delegateToggle?.handleToggle(settingItem: nil)
    }
    
    //Scroller animation for first section
    @objc func changeImage(){
        if counter < bannerImagesNames.count{
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: [.centeredVertically, .centeredHorizontally], animated: true)
            counter += 1
        }else{
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            //self.collectionView.isPagingEnabled = false
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
        }
    }
    
}

extension MainController :  UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return bannerImagesNames.count
        }else if section == 1{
            return featuredIngredients.count
        }
        else if section == 2{
            return featuredRandomMeals.count
        }
        else if section == 3{
            return featuredAreas.count
        }
        else if section == 4{
            //return featuredCategories.count
            return 4
        }else if section == 5{
            return latestMeals.count
        }
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: bannerIdentifierCell, for: indexPath) as! BannerCell
            cell.mainImage.image =  UIImage(named: "\(bannerImagesNames[indexPath.row])")
            return cell
        }
        else if indexPath.section == 1{
            let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: featuredIngridientCell, for: indexPath) as! FeaturedTextCell
            cell.tagName.text =  featuredIngredients[indexPath.row].strIngredient
            return cell
        }
        
        else if indexPath.section == 2 {
            let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: featuredMealIdentifierCell, for: indexPath) as! BannerCell
            cell.mainImage.loadImageUrlString(urlString: featuredRandomMeals[indexPath.row].strMealThumb!)
            return cell
        }
        
        else if indexPath.section == 3{
            let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: featuredAreaCellIdentifier, for: indexPath) as! FeaturedTextCell
            cell.tagName.text =  featuredAreas[indexPath.row].strArea
            return cell
        }

        else if indexPath.section == 4 {
            let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: featuredCategoryIdentifierCell, for: indexPath) as! BannerCell
            cell.typeBanner  = .category
            cell.mainImage.loadImageUrlString(urlString: featuredCategories[indexPath.row].thumbnail!)
            return cell
        }else if indexPath.section == 5{
            let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: latestMealIdentifierCell, for: indexPath) as! BannerCell
            cell.mainImage.loadImageUrlString(urlString: latestMeals[indexPath.row].strMealThumb!)
            return cell
        }
        
        let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierMain, for: indexPath)
        cell.backgroundColor =  .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 2{
            let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
            header.label.text  =   "Featured Meal"
            return header
        }else if indexPath.section == 5{
            let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
            header.label.text  =   "Latest Meal"
            return header
        }
        
        let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1{
            
            guard let ingredientName = featuredIngredients[indexPath.row].strIngredient else {
                return
            }
            let controller  = SingleIngredientController(ingredientName:  ingredientName)
            controller.ingredient =  featuredIngredients[indexPath.row]
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
            
        }else if indexPath.section == 2{
            
            guard let mealId =  featuredRandomMeals[indexPath.row].idMeal else {
                return
            }
            let controller  =  MealViewController(idMeal: mealId)
            present(controller, animated: true, completion: nil)

        }else if indexPath.section == 3{
            
            guard let areaName  = featuredAreas[indexPath.row].strArea else {
                return
            }
            let controller  = IndividualAreaList(areaFood: areaName)
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
            
        }else if indexPath.section == 4{
            guard let categoryNameToPass  =  featuredCategories[indexPath.row].category else {
                return
            }
            
            let controller =  CategoryList(categoryName: categoryNameToPass)
            controller.category = featuredCategories[indexPath.row]
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
            
        }else if indexPath.section == 5{
            guard let mealId =  latestMeals[indexPath.row].idMeal else {
                return
            }
            let controller  =  MealViewController(idMeal: mealId)
            present(controller, animated: true, completion: nil)

        }
    }
    
    
    //FETCHING DATA
    
    private func fetchFeaturedTags(){
        //let stringUrl  = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
        MealService.shared.getAllIngridient() { (result) in
            switch result{
            
            case .success(let ingriendients):
                var ingredientsFiltered = ingriendients.filter { (ingredient) -> Bool in
                    if  let unwrappedIngredient = ingredient.strIngredient {
                        return unwrappedIngredient.count <= 9
                    }
                    return false
                    
                }
                var slicedIngredientsFiltered  = [Ingredient]()
                for ing in 0...10{
                    
                    slicedIngredientsFiltered.append(ingredientsFiltered[ing])
                }
                
                self.featuredIngredients.append(contentsOf: slicedIngredientsFiltered)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("There is an error in the code \(error.localizedDescription)")
            }
        }
    }
    
    
    
    private func feathThreeRandomMeals(){
      
        
//        let dispatchGroup =  DispatchGroup()
//        for _ in  1...3{
//            dispatchGroup.enter()
//
//            MealService.shared.getIndividualRandomMeals() { (result) in
//                switch result{
//
//                case .success(let meals):
//                    self.featuredRandomMeals.append(meals[0])
//
//                    dispatchGroup.leave()
//                case .failure(let error):
//                    print("The errror is \(error.localizedDescription)")
//                }
//            }
//
//        }
//        dispatchGroup.notify(queue: .main) {
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
//
        
    }
    private func fetchFeatured10Meals(){
        MealService.shared.getManyRandomMeals { (result) in
            switch result{
            
            case .success(let meals):
                self.featuredRandomMeals =  meals
                
                //dispatchGroup.leave()
            case .failure(let error):
                print("The errror is \(error.localizedDescription)")
            }
        }
        
    }
    
    private func fetchLatestMeals (){
        MealService.shared.getLatestMeals { (result) in
            switch result{
            
            case .success(let meals):
                self.latestMeals =  meals
                
                //dispatchGroup.leave()
            case .failure(let error):
                print("The errror is \(error.localizedDescription)")
            }
        }
    }
    
    
    private func featchFeatureArea(){
        //let stringUrl  = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
        MealService.shared.getAllArea() { (result) in
            switch result{
            
            case .success(let areas):
                var areasFiltered = areas.filter { (area) -> Bool in
                    if  let unwrappedAreas = area.strArea {
                        return unwrappedAreas.count <= 9
                    }
                    return false
                }
                var slicedAreasFiltered  = [AreaFood]()
                for ing in 0...10{
                    
                    slicedAreasFiltered.append(areasFiltered[ing])
                }
                
                self.featuredAreas.append(contentsOf: slicedAreasFiltered)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("There is an error in the code \(error.localizedDescription)")
            }
        }
        
    }
    
    private func fetchFeaturedCategories(){
        //let categoryUrl = "https://www.themealdb.com/api/json/v1/1/categories.php"
        
        MealService.shared.getAllCategories() { (result) in
            switch result{
            
            case .success(let categories):
                var categoriesSliced =  categories[0...9]
                self.featuredCategories.append(contentsOf: categoriesSliced)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("The error is presented \(error.localizedDescription)")
            }
            
        }
    }
    
    
    
    
    //Hide bar copied from :
    //stackoverflow.com/questions/31928394/ios-swift-hide-show-uitabbarcontroller-when-scrolling-down-up
    
    //     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    //            if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
    //                changeTabBar(hidden: true, animated: true)
    //            }else{
    //                changeTabBar(hidden: false, animated: true)
    //            }
    //
    //        }
    //
    //    func changeTabBar(hidden:Bool, animated: Bool){
    //            let tabBar = self.tabBarController?.tabBar
    //            if tabBar!.isHidden == hidden{ return }
    //            let frame = tabBar?.frame
    //            let offset = (hidden ? (frame?.size.height)! : -(frame?.size.height)!)
    //            let duration:TimeInterval = (animated ? 0.4 : 0.0)
    //            tabBar?.isHidden = false
    //            if frame != nil
    //            {
    //                UIView.animate(withDuration: duration,
    //                                           animations: {tabBar!.frame = frame!.offsetBy(dx: 0, dy: offset)},
    //                                           completion: {
    //                                            print($0)
    //                                            if $0 {tabBar?.isHidden = hidden}
    //                })
    //            }
    //        }
    
}







class Header : UICollectionReusableView {
    
    var label : UILabel  = {
        let label = UILabel()
        label.text =  "Categories"
        label.font =  UIFont.boldSystemFont(ofSize: 24)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewAllLabel : UILabel =  {
        let label =  UILabel()
        label.text =  "View All"
        label.textColor =  .systemBlue
        label.font =  UIFont.systemFont(ofSize: 18)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.anchor(top: nil, left: leadingAnchor, right: nil, bottom: nil, paddingTop: nil, paddingLeft: 0, paddingRight: nil, paddingBottom: nil, width: nil, height: nil)
        label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive  = true
    }
    
}



