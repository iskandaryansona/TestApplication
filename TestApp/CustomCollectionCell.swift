//
//  CustomCollectionCellCollectionViewCell.swift
//  TestApp
//
//  Created by Sona on 21.04.24.
//

import UIKit
import Kingfisher

class CustomCollectionCell: UICollectionViewCell {
    
    static var id: String {
        get {
            return String(describing: self)
        }
    }
    
    lazy var img: UIImageView = {
        let im = UIImageView(frame: .zero)
        im.translatesAutoresizingMaskIntoConstraints = false
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(img)
        configConstraint()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
    }
    
    private func configConstraint(){
        NSLayoutConstraint.activate(
            [img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
             img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             img.topAnchor.constraint(equalTo: contentView.topAnchor),
             img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ])
    }
    
    func configUI(model: PhotoModel){
        if let imgUrl = URL(string: model.url) {
            let resource = KF.ImageResource(downloadURL: imgUrl, cacheKey: model.thumbnailUrl)
            img.kf.setImage(with: resource)
        }
        
    }
    
}
