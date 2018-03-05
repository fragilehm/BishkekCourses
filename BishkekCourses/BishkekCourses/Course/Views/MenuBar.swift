//
//  MenuBar.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/7/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

protocol MenuBarDelegate : class {
    func iconPressed(_ index: Int)
}
class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    weak var cellDelegate: MenuBarDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: Constants.DetailedCourse.CellID.MENU_COLLECTIONVIEW_CELL)
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.DetailedCourse.CellID.MENU_COLLECTIONVIEW_CELL, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: Constants.DetailedCourse.MENU_IMAGES[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.lightGray
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellDelegate?.iconPressed(indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 5, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
