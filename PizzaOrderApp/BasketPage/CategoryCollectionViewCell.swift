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
        let url = URL(string: "http://i.stack.imgur.com/WCveg.jpg")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                iv.image = UIImage(data: data!)
            }
        }
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(categoryImage)
        
        categoryImage.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
