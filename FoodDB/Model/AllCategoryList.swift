//
//  CategoryList.swift
//  FoodDB
//
//  Created by Navid Sheikh on 20/07/2021.
//

import Foundation
import UIKit


struct AllCategoryList: Decodable {
    var meals : [CategoryListIndividual]?
}


struct CategoryListIndividual: Decodable{
    var strMeal : String?
    var strMealThumb: String?
    var idMeal: String?
    
}
