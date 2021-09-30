//
//  AreaTableController.swift
//  FoodDB
//
//  Created by Navid Sheikh on 23/07/2021.
//

import Foundation
import UIKit

class AreaTableController : UITableViewController{
    
    let identiefer : String  = "identifier"
    var countries : [AreaFood]?
    
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        tableView.rowHeight =  70
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identiefer)
        fetchData()
        setUpNavigation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpNavigation (){
        navigationItem.title =  "Areas"
        navigationController?.navigationBar.prefersLargeTitles =  false
    }
    
    
    private func fetchData(){
        //let areaString =  "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
        MealService.shared.getAllArea() { [weak self] (result) in
            
            guard let self = self else { return }
            switch result{
            
            case .success(let areaList):
                self.countries =  areaList
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fond \(error.localizedDescription)")
            }
        }
    }
}

extension AreaTableController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let countries = countries   {
            return countries.count
        }
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiefer, for: indexPath)
        cell.accessoryType  = .disclosureIndicator
        if let countries = countries{
            cell.textLabel?.text  =  countries[indexPath.row].strArea
        }else {
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let countries =  countries  {
            guard let areaName  = countries[indexPath.row].strArea else {
                return
            }
            let controller  = IndividualAreaList(areaFood: areaName)
            controller.hidesBottomBarWhenPushed  = true
            navigationController?.pushViewController(controller, animated: true)
        }
        return
    }
    
}

//Header
extension AreaTableController{
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageView  =  UIImageView()
        imageView.image  =  UIImage(named: "flag")
        imageView.contentMode  = .scaleAspectFill
        imageView.backgroundColor =  .systemGray
        return imageView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
}
