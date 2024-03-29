//
//  MenuController.swift
//  FoodDB
//
//  Created by Navid Sheikh on 06/08/2021.
//

import Foundation
import UIKit


class MenuController : UIViewController{
    
    weak var delegate:  MenuToggleProtocol?
    
    
    let menuCellIdentifier : String  =  "menuCellIdentifier"
    static var headerKindMenu : String = "headerMenuLogoId"
    let logoMenuHeaderIdentifier : String   = "headerIdentifierMenu"
    
    let collectionView:  UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        setUpCollectionView()
        let swipeRightRecognizer  = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        swipeRightRecognizer.direction = .left
        self.collectionView.addGestureRecognizer(swipeRightRecognizer)
    }
    
    
    @objc public func swipeRight(){
        delegate?.handleToggle(settingItem: nil)
    }
    private func setUpCollectionView(){
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier:  menuCellIdentifier)
        
        collectionView.register(CustomHeaderForMenu.self, forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderForMenu.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right:  view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    }
    
}

extension MenuController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SettingsV2.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let setting  =  SettingsV2.init(rawValue: indexPath.row)
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellIdentifier, for: indexPath) as! MenuCell
        cell.label.text =  setting?.description
        if let stringImage  = setting?.imageSetting {
            cell.iconMenu.image =  UIImage(systemName: stringImage)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CustomHeaderForMenu.identifier, for: indexPath)  as! CustomHeaderForMenu
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemSelected  =  SettingsV2.init(rawValue: indexPath.row)
        delegate?.handleToggle(settingItem: itemSelected)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    
    
}




class CustomHeaderForMenu : UICollectionReusableView{
    static let identifier  =  "HeaderCollectionMenuReusableView"
    
    let imageLogo  :  UIImageView =  {
        let imageView  = UIImageView()
        imageView.image =  UIImage(named: "logov3_white")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.contentMode  = .scaleToFill
        return imageView
    }()
    
    let barDividier : UIView =  {
        let view  = UIView()
        view.backgroundColor =  .systemGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageLogo)
        imageLogo.anchor(top: topAnchor, left: leadingAnchor, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: 0, paddingBottom: nil, width: 180, height: 35)
        //addSubview(barDividier)
        //barDividier.anchor(top: imageLogo.bottomAnchor, left: leadingAnchor, right: trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: -56, paddingBottom: 0, width: nil, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
