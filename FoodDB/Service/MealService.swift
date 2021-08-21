//
//  MealDBApi.swift
//  FoodDB
//
//  Created by Navid Sheikh on 13/07/2021.
//

import Foundation
import UIKit


enum NetworkError: Error{
    case fetchFailed
    case invalidUrl
    case conversionFailed
}

class MealService {
    
    static let shared  =  MealService()
    
    private init(){
        
    }
    let categoryFilterUrl  = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    let areaFilterUrl  = "https://www.themealdb.com/api/json/v1/1/filter.php?a="
    let ingriidientFilterUrl =  "https://www.themealdb.com/api/json/v1/1/filter.php?i="
    let letterFilterUrl = "https://www.themealdb.com/api/json/v1/1/search.php?f="
    
    
}

extension MealService{
    
    public func getAllCategories(with urlString : String, completion : @escaping(Result<[Category], NetworkError>) -> Void){
        
        guard let url =  URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data =  data, error == nil else {
                completion(.failure(.fetchFailed))
                return
            }
            
 
            do{
                let jsonDecorder  = JSONDecoder()
                let categoryList  = try? jsonDecorder.decode(FoodCategoryList.self, from: data)
                guard let categoryListConverted =  categoryList?.categories else {
                    completion(.failure(.conversionFailed))
                    return
                }
                completion(.success(categoryListConverted))
                
            }
        }.resume()
        
    }
    
    public func  getIndividualListCategory(with categoryName : String, completion : @escaping(Result<[CategoryListIndividual], NetworkError>) -> Void){
        
        
        let fullPath  =  categoryFilterUrl +  categoryName
        guard let url = URL(string: fullPath) else {
            completion(.failure(.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data , error == nil else {
                completion(.failure(.fetchFailed))
                return
            }
            
            do {
                let decoder  =  JSONDecoder()
                
                let singleListCegory =  try? decoder.decode(AllCategoryList.self, from: data)
                guard let singleListCategoryConveteed  =  singleListCegory?.meals else {
                    completion(.failure(.conversionFailed))
                    return
                }
                
                completion(.success(singleListCategoryConveteed))
                
                
            }
        
        
        
        
        }.resume()
    }
    
    
    public func getAllArea(with urlString : String, completion : @escaping(Result<[AreaFood], NetworkError>) -> Void){
        
        guard let url =  URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data =  data, error == nil else {
                completion(.failure(.fetchFailed))
                return
            }
            
 
            do{
                let jsonDecorder  = JSONDecoder()
                let areaList  = try? jsonDecorder.decode(AreaFoodList.self, from: data)
                guard let areaListConverted =  areaList?.meals else {
                    completion(.failure(.conversionFailed))
                    return
                }
                completion(.success(areaListConverted))
                
            }
        }.resume()
        
    }
    
    
    public func  getIndividualListArea(with areaName : String, completion : @escaping(Result<[CategoryListIndividual], NetworkError>) -> Void){
        
        
        let fullPath  =  areaFilterUrl +  areaName
        guard let url = URL(string: fullPath) else {
            completion(.failure(.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data , error == nil else {
                completion(.failure(.fetchFailed))
                return
            }
            
            do {
                let decoder  =  JSONDecoder()
                
                let singleListCegory =  try? decoder.decode(AllCategoryList.self, from: data)
                guard let singleListCategoryConveteed  =  singleListCegory?.meals else {
                    completion(.failure(.conversionFailed))
                    return
                }
                
                completion(.success(singleListCategoryConveteed))
                
                
            }
        
        
        
        
        }.resume()
    }
    
    
    public func getAllIngridient(with urlString : String, completion : @escaping(Result<[Ingredient], NetworkError>) -> Void){
        
        guard let url =  URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data =  data, error == nil else {
                completion(.failure(.fetchFailed))
                return
            }
            
 
            do{
                let jsonDecorder  = JSONDecoder()
                let ingredientList  = try? jsonDecorder.decode(ListIngredients.self, from: data)
                guard let ingredientListConverted =  ingredientList?.meals else {
                    completion(.failure(.conversionFailed))
                    return
                }
                completion(.success(ingredientListConverted))
                
            }
        }.resume()
        
    }
    
    
    public func  getIndividualListIngredient(with ingredient : String, completion : @escaping(Result<[CategoryListIndividual], NetworkError>) -> Void){
        
        
        let fullPath  =  ingriidientFilterUrl +  ingredient
        guard let url = URL(string: fullPath) else {
            completion(.failure(.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data , error == nil else {
                completion(.failure(.fetchFailed))
                return
            }
            
            do {
                let decoder  =  JSONDecoder()
                
                let singleListCegory =  try? decoder.decode(AllCategoryList.self, from: data)
                guard let singleListCategoryConveteed  =  singleListCegory?.meals else {
                    completion(.failure(.conversionFailed))
                    return
                }
                
                completion(.success(singleListCategoryConveteed))
                
                
            }
        
        
        
        
        }.resume()
    }
    
    public func  getIndividualListLetter(with letter : String, completion : @escaping(Result<[Meal], NetworkError>) -> Void){
        
        
        let fullPath  =  letterFilterUrl +  letter
        guard let url = URL(string: fullPath) else {
            completion(.failure(.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data , error == nil else {
                completion(.failure(.fetchFailed))
                return
            }
            
            do {
                let decoder  =  JSONDecoder()
                
                let singleListLetter =  try? decoder.decode(MealList.self, from: data)
                guard let singleListLetterConverted  =  singleListLetter?.meals else {
                    completion(.failure(.conversionFailed))
                    return
                }
                
                completion(.success(singleListLetterConverted))
            }
        }.resume()
    }

    

    public func  getIndividualMeals(with url : String, completion : @escaping(Result<[Meal], NetworkError>) -> Void){
        
        
        //let fullPath  =  letterFilterUrl +  letter
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data , error == nil else {
                completion(.failure(.fetchFailed))
                return
            }
            
            do {
                let decoder  =  JSONDecoder()
                
                let singleListLetter =  try? decoder.decode(MealList.self, from: data)
                guard let singleListLetterConverted  =  singleListLetter?.meals else {
                    completion(.failure(.conversionFailed))
                    return
                }
                
                completion(.success(singleListLetterConverted))
            }
        }.resume()
    }
    
    
    
//    public func getImageFromUrl(with urlString : String) -> Data?{
//        
//        guard let url =  URL(string: urlString) else {
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            guard let data =  data, error == nil else {
//             
//                return
//            }
//            
//            return data
//        }.resume()
//        
//    }
    
    
    
    
    
    
}
