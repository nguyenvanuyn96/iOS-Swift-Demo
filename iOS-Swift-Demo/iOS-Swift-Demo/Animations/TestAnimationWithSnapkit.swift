//
//  TestAnimationWithSnapkit.swift
//  iOS-Swift-Demo
//
//  Created by Nguyen Van Uy on 5/23/18.
//  Copyright © 2018 Uy Nguyen Van. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TestAnimationWithSnapkit: UIViewController {
    let viewA: UIView = UIView()
    let viewB: UIView = UIView()
    let viewC: UIView = UIView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        self.setupView()
        self.setupLayout()
    }
    
    //MARK: - Private methods
    private func setupView() {
        self.edgesForExtendedLayout = []
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change", style: UIBarButtonItemStyle.plain, target: self, action: #selector(didTapRightBarButton))
        
        self.view.backgroundColor = UIColor.lightGray
        
        self.viewA.backgroundColor = UIColor.blue
        self.viewA.layer.cornerRadius = 2
        
        self.viewB.backgroundColor = UIColor.red
        self.viewB.layer.cornerRadius = 2
        
        self.viewC.backgroundColor = UIColor.green
        self.viewC.layer.cornerRadius = 2
        
        self.view.addSubview(self.viewA)
        self.view.addSubview(self.viewB)
        self.view.addSubview(self.viewC)
    }
    
    private func setupLayout() {
        
        self.viewB.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(100)
            make.leading.equalTo(self.viewA.snp.trailing).offset(5)
            make.trailing.equalTo(self.viewC.snp.leading).offset(-5)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.centerX.equalToSuperview()
        }
        
        self.viewA.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(100)
        }
        
        self.viewC.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(100)
        }
    }
    
    var isShowViewB: Bool = true
    
    @objc private func didTapRightBarButton() {
        let animateWithoutAnimation = {
            
            
            self.viewB.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.height.equalTo(100)
                make.leading.equalTo(self.viewA.snp.trailing).offset(5)
                make.trailing.equalTo(self.viewC.snp.leading).offset(-5)
                make.width.equalToSuperview().multipliedBy(self.isShowViewB ? 0 : 0.3)
                make.centerX.equalToSuperview()
            }
            self.isShowViewB = !self.isShowViewB
            
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            animateWithoutAnimation()
        })
    }
    
}
