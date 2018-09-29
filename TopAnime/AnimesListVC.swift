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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.backgroundColor = UIColor.darkBlueColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.white
        
        navigationItem.title = "Animes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(handleAddNewAnimeAction))
        fetchAnimes()
    }
    
    func fetchAnimes(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Anime>(entityName: "Anime")
        
        do{
            let animes = try context.fetch(fetchRequest)
            self.animes = animes
            self.tableView.reloadData()
            
        }catch let error {
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.whiteBlueColor
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = animes[indexPath.row].name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor.lightBlueColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            let anime = self.animes[indexPath.row]
            
            // remove locally
            self.animes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //remove from CoreData
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(anime)
            
            do{
                try context.save()
            }catch let error{
                print(error)
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (_, indexPath) in
            let anime = self.animes[indexPath.row]
        }
        
        return [deleteAction, editAction]
    }
}

extension AnimesListVC: CreateAnimeVCDelegate{
    func didAddAnime(anime: Anime) {
        animes.append(anime)
        tableView.insertRows(at: [IndexPath(row: animes.count-1, section: 0)], with: .automatic)
    }
}
