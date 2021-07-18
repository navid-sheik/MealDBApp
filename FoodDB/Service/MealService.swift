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
}
