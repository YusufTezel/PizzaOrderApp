//
//  CategoryCollectionViewCell.swift
//  PizzaOrderApp
//
//  Created by Yusuf Tezel on 07/01/2018.
//  Copyright © 2018 tezel. All rights reserved.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    let categoryImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(categoryImage)
        contentView.layer.masksToBounds = false
        layer.cornerRadius = 10
        layer.masksToBounds = true
        categoryImage.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
