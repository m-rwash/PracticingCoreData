//
//  ViewController.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 9/29/18.
//  Copyright © 2018 mrwash. All rights reserved.
//

import UIKit

class AnimesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        navigationItem.title = "Animes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(handleAddNewAnimeAction))
        
        setupNavigationBarStyle()
    }

    @objc func handleAddNewAnimeAction() {
        print("Add new Anime Button!!")
    }
    
    func setupNavigationBarStyle(){
        navigationController?.navigationBar.isTranslucent = false
        let lightBlueColor = UIColor(red: 0, green: 180/255, blue: 251/255, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = lightBlueColor
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.white ]
        navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.white ]
    }

}

