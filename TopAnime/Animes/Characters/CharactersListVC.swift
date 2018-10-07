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
    
    var maleCharacters   = [Character]()
    var femaleCharacters = [Character]()
    var allCharacters = [[Character]]()
    
    var genders = [CharacterGender.Male.rawValue, CharacterGender.Female.rawValue, CharacterGender.Undefined.rawValue]

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
        createCharacterVC.anime = anime
        let navBarVC = UINavigationController(rootViewController: createCharacterVC)
        present(navBarVC, animated: true, completion: nil)
    }
    
    func fetchCharacters(){
        guard let animeCharacters = anime?.characters?.allObjects as? [Character] else { return }
        
        characters = []
        
        genders.forEach { (gender) in
            allCharacters.append(animeCharacters.filter { $0.characterInfo?.gender == gender } )
        }
        
//        self.characters = animeCharacters
//
//        maleCharacters   = animeCharacters.filter{$0.characterInfo?.gender == CharacterGender.Male.rawValue}
//
//        femaleCharacters = animeCharacters.filter{$0.characterInfo?.gender == CharacterGender.Female.rawValue}
//
//        allCharacters = [ maleCharacters, femaleCharacters ]
        
    }
    
    
}
