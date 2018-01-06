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
        topBar.addSubview(amountLabel)
        topBar.addSubview(addButton)
        snapControlsAndViews()
        addButton.addTarget(self, action: #selector(addButtonClicked), for: UIControlEvents.touchUpInside)
    }
    
    @objc func addButtonClicked(){
        print("add button clicked...")
    }
}


extension BasketViewController{
    func snapControlsAndViews(){
        
        //topbar
        topBar.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            let height = view.bounds.height / 6
            $0.height.equalTo(height)
        })
        
        amountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        addButton.snp.makeConstraints({
            $0.bottom.equalToSuperview()
            $0.trailing.equalTo(-15)
        })
        
    }
}

