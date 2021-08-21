//
//  MainCardSlider.swift
//  FoodDB
//
//  Created by Navid Sheikh on 31/07/2021.
//

import Foundation
import CardSlider

struct Item: CardSliderItem {
    var image: UIImage
    
    var rating: Int?
    
    var title: String
    
    var subtitle: String?
    
    var description: String?

}



//protocol ProtocolDismiss{
//    func dismissController (controller : CardSliderViewController)
//}

class MainCardSlider: UIViewController, CardSliderDataSource{
   
    
//    func dismissController(controller : CardSliderViewController) {
//        controller.dismiss(animated: true, completion: nil)
//    }
    
   

    
    
    
    var data  =  [Item]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchData()
    
    }
    
    
    private func fetchData(){
        let dispatchGroup  =  DispatchGroup()
        
        for i in 0...20{
            let url =  "https://www.themealdb.com/api/json/v1/1/random.php"
            dispatchGroup.enter()
            MealService.shared.getIndividualMeals(with: url) { (result) in
                switch(result){
                
                case .success(let meals):
                    
                    
                    let imageUrl = URL(string: meals[0].strMealThumb!)!
                    let imageData = try! Data(contentsOf: imageUrl)

                    let imageMeal = UIImage(data: imageData)
                  
                    let item = Item(image: imageMeal ?? UIImage(named: "placeholder")!, rating: nil, title: meals[0].strMeal!, subtitle: meals[0].strArea, description: meals[0].strInstructions)
                    self.data.append(item)
                    dispatchGroup.leave()
                case .failure(let error):
                    print("The error in somethign\(error)")
                    dispatchGroup.leave()
                }
            }
            
        }
        
        
        dispatchGroup.notify(queue: .main) {
            print("Finish fetching ")
            let cardSlider  =  CardSliderViewController.with(dataSource: self)
            cardSlider.title =  "Featured Meals"
            cardSlider.modalPresentationStyle  =  .fullScreen
            
            self.present(cardSlider, animated: true, completion: nil)
        }
    }
    
    
    
    private func addCards(){
        //data.append()
    }
    
    func item(for index: Int) -> CardSliderItem {
      return data[index]
    }
    
    func numberOfItems() -> Int {
        return data.count
    }
    
    
    
    
    
}
