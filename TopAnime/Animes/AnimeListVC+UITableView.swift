//
//  AnimeListVC+UITableView.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 9/30/18.
//  Copyright © 2018 mrwash. All rights reserved.
//

import UIKit

extension AnimesListVC {

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.whiteBlueColor

        let label = UILabel()
        
        view.addSubview(label)
        
        label.text = "Titles"
        label.textAlignment = .natural
        label.textColor = UIColor.darkBlueColor
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No animes available... "
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return animes.count == 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! AnimeCell
        let anime = animes[indexPath.row]
        cell.anime = anime
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteActionHandler)
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editActionHandler)
        editAction.backgroundColor = UIColor.darkBlueColor
        
        return [deleteAction, editAction]
    }
    
    private func deleteActionHandler(action: UITableViewRowAction, indexPath: IndexPath){
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
    
    private func editActionHandler(action: UITableViewRowAction, indexPath: IndexPath){
        let anime = self.animes[indexPath.row]
        let editAnimeVC = CreateAnimeVC()
        editAnimeVC.anime = anime
        editAnimeVC.delegate = self
        let navVC = UINavigationController(rootViewController: editAnimeVC)
        present(navVC, animated: true, completion: nil)
    }
}
