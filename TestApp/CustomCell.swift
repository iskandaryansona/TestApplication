//
//  CustomCell.swift
//  TestApp
//
//  Created by Sona on 21.04.24.
//

import Foundation
import UIKit


class CustomCell: UITableViewCell {
            
    let buffer = 5 
    var totalElements = 0
    
    private lazy var imageCollections: UICollectionView = {
        let fl = UICollectionViewFlowLayout()
        fl.minimumInteritemSpacing = 10
        fl.scrollDirection = .horizontal
        fl.itemSize = CGSize(width: 70, height: 70)
        
        let cl = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), collectionViewLayout: fl)
        cl.dataSource = self
        cl.delegate = self
        cl.translatesAutoresizingMaskIntoConstraints = false
        
        cl.register(CustomCollectionCell.self, forCellWithReuseIdentifier: CustomCollectionCell.id)
        return cl
    }()
    
    var photos: [PhotoModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addSubview(imageCollections)
        imageCollections.delegate = self
        imageCollections.dataSource = self
        setUpConstraint()
        
    }
    
    private func setUpConstraint(){
        NSLayoutConstraint.activate(
            [imageCollections.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             imageCollections.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
             imageCollections.widthAnchor.constraint(equalTo: self.widthAnchor),
             imageCollections.heightAnchor.constraint(equalToConstant: 70)
            ])
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configUI(photo: [PhotoModel]){
        self.photos = photo
        self.imageCollections.reloadData()
    }
    
    
}


extension CustomCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalElements = buffer + photos.count
                return totalElements
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollections.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath) as? CustomCollectionCell else
        { return UICollectionViewCell() }
        let currentCell = indexPath.row % photos.count
        cell.configUI(model: photos[currentCell])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    
}
extension CustomCell: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let itemSize = imageCollections.contentSize.width/CGFloat(totalElements)
        
        if scrollView.contentOffset.x > itemSize*CGFloat(photos.count){
            imageCollections.contentOffset.x -= itemSize*CGFloat(photos.count)
        }
        if scrollView.contentOffset.x < 0  {
            imageCollections.contentOffset.x += itemSize*CGFloat(photos.count)
        }
    }
}
