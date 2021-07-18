//
//  Category.swift
//  FoodDB
//
//  Created by Navid Sheikh on 16/07/2021.
//

import Foundation
import UIKit





struct FoodCategoryList:  Decodable {
    var categories :  [Category]?
}

struct Category: Decodable{
    var id: String?
    var category : String?
    var thumbnail: String?
    var description: String?
    
    
    enum CodingKeys : String, CodingKey{
        case id =  "idCategory"
        case category =  "strCategory"
        case thumbnail =  "strCategoryThumb"
        case description =  "strCategoryDescription"
        
    }
}


