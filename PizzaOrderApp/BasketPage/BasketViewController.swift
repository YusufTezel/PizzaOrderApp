//
//  ViewController.swift
//  PizzaOrderApp
//
//  Created by Yusuf Tezel on 29/12/2017.
//  Copyright © 2017 tezel. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class BasketViewController: UIViewController {
    
    var categoryArray = [Category]()
    
    let topBar: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.backgroundColor = .red
        c.showsHorizontalScrollIndicator = false
        return c
    }()
    
    let amountLabel: UILabel = {
        let l = UILabel()
        l.text = "0,00 kr"
        l.textColor = .white
        l.font = l.font.withSize(45)
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(topBar)
        view.addSubview(categoryCollectionView)
        topBar.addSubview(amountLabel)
        initFirebase()
        
        snapControlsAndViews()
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCellId")
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
    
    func initFirebase(){
        let ref = Database.database().reference()
        
        ref.child("menu").child("category").observe(.value, with: { (snapshot) -> Void in
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                let value = rest.value as? NSDictionary
                let name = value?["name"] as! String
                let priority = value?["priority"] as! Int
                let imageUrl = value?["imageUrl"] as! String
                
                guard let url = URL(string: imageUrl) else { return }
                
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    }
                    guard let data = data else { return }
                    self.categoryArray.append(Category(name: name, priority: priority, data: data))
                    self.categoryArray = self.categoryArray.sorted(by: { $0.priority < $1.priority })
                    DispatchQueue.main.async(execute: {
                        self.categoryCollectionView.reloadData()
                    })
                }.resume()
            }
        })
        
        
    }
}

extension BasketViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCellId", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryImage.image = UIImage(data: categoryArray[indexPath.row].data!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}


extension BasketViewController{
    func snapControlsAndViews(){
        
        //topbar
        topBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            let height = view.bounds.height / 8
            $0.height.equalTo(height)
        }
        
        amountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().inset(15)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(topBar.snp.bottom)
            $0.height.equalTo((90))
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
    }
}

