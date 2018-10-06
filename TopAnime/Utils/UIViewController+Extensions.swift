//
//  UIViewController+Extensions.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 10/6/18.
//  Copyright © 2018 mrwash. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func setupPlusButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"),style: .plain, target: self, action: selector)
    }
    
    func setupCancelButtonInNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector (handleCancelModal))
    }
    
    func setupSaveButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: selector)
    }
    
    @objc func handleCancelModal(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupInputsHolderView(height: CGFloat) -> UIView{
        
        let inputsHolderView = UIView()
        inputsHolderView.translatesAutoresizingMaskIntoConstraints = false
        inputsHolderView.backgroundColor = UIColor.whiteBlueColor
        
        view.addSubview(inputsHolderView)
        
        inputsHolderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        inputsHolderView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        inputsHolderView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        inputsHolderView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return inputsHolderView
    }
}
