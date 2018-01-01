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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(topBar)
        snapControlsAndViews()
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
        
    }
}

