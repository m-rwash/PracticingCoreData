//
//  CharactersViewController.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 10/6/18.
//  Copyright © 2018 mrwash. All rights reserved.
//

import UIKit
import CoreData

class CharactersListVC: UITableViewController {

    var anime: Anime?
    var characters = [Character]()
    
    let cellID = "characterCellID"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.darkBlueColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupPlusButtonInNavBar(selector: #selector(handleAddCharacterAction))
        
        fetchCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = anime?.name
    }
    
    @objc func handleAddCharacterAction(){
        let createCharacterVC = CreateCharacterVC()
        createCharacterVC.delegate = self
        let navBarVC = UINavigationController(rootViewController: createCharacterVC)
        present(navBarVC, animated: true, completion: nil)
    }
    
    private func fetchCharacters(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let request = NSFetchRequest<Character>(entityName: "Character")
        do{
            let characters = try context.fetch(request)
            self.characters = characters
            
        }catch let error{
            print(error)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = characters[indexPath.row].name
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.lightBlueColor
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
}
