//
//  ViewController.swift
//  PizzaOrderApp
//
//  Created by Yusuf Tezel on 29/12/2017.
//  Copyright © 2017 tezel. All rights reserved.
//

import UIKit
import SnapKit

class BasketViewController: UIViewController {
    
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
        return c
    }()
    
    let amountLabel: UILabel = {
        let l = UILabel()
        l.text = "0,00 kr"
        l.textColor = .white
        l.font = l.font.withSize(40)
        return l
    }()
    
    let addButton: UIButton = {
        let b = UIButton()
        b.setTitle("+", for: UIControlState.normal)
        b.setTitleColor(.white, for: UIControlState.normal)
        b.titleLabel?.font = b.titleLabel?.font.withSize(50)
        b.titleLabel?.text = "+"
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(topBar)
        view.addSubview(categoryCollectionView)
        topBar.addSubview(amountLabel)
        topBar.addSubview(addButton)
        
        snapControlsAndViews()
        addButton.addTarget(self, action: #selector(addButtonClicked), for: UIControlEvents.touchUpInside)
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCellId")
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
    
    @objc func addButtonClicked(){
        print("add button clicked...")
        let ov = OrderViewController()
        ov.modalPresentationStyle = .popover
        present(ov, animated: true, completion: nil)
    }
}

extension BasketViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCellId", for: indexPath) as! CategoryCollectionViewCell
        if cell.categoryImage.image == nil {
            let url = URL(string: "http://i.stack.imgur.com/WCveg.jpg")
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    cell.categoryImage.image = UIImage(data: data!)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
}


extension BasketViewController{
    func snapControlsAndViews(){
        
        //topbar
        topBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            let height = view.bounds.height / 6
            $0.height.equalTo(height)
        }
        
        amountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().inset(15)
        }
        
        addButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.equalTo(-15)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(topBar.snp.bottom)
            $0.height.equalTo((90))
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
    }
}

