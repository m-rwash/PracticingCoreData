//
//  ViewController.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 9/29/18.
//  Copyright © 2018 mrwash. All rights reserved.
//

import UIKit
import CoreData

class AnimesListVC: UITableViewController {
    
    var animes = [Anime]()
    
    let cellID = "animeCellID"

    // MARK: - Setup view
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.animes = CoreDataManager.shared.fetchAnimes()

        // MARK: Setup UITableView
        tableView.register(AnimeCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = UIColor.darkBlueColor
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.white
        tableView.allowsSelection = true
        
        // MARK: Setup Navigation Bar
        navigationItem.title = "Animes"

        setupPlusButtonInNavBar(selector: #selector(handleAddNewAnimeAction))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleResetAction))
    }
    
    // MARK: - Handle View Actions
    @objc func handleResetAction() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Anime.fetchRequest())
        do{
            try context.execute(batchDeleteRequest)
            
            var indexPathsToRemove = [IndexPath]()
            for(index, _) in animes.enumerated(){
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            animes.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .left)
        }catch let error{
            print(error)
        }
    }
    
    @objc func handleAddNewAnimeAction() {
        print("Add new Anime Button!!")
        let createAnimeVC = CreateAnimeVC()
        createAnimeVC.delegate = self
        let navVc = UINavigationController(rootViewController: createAnimeVC)
        present(navVc, animated: true, completion: nil)
    }
    
}
