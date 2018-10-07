//
//  CharactersListVC+CreateCharacter.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 10/6/18.
//  Copyright © 2018 mrwash. All rights reserved.
//
import UIKit

extension CharactersListVC: CreateCharacterVCDelegate{
    func didAddCharacter(character: Character) {
//        fetchCharacters()
//        self.tableView.reloadData()

        guard let section = genders.index(of: (character.characterInfo?.gender)!) else { return }
        
        let row = allCharacters[section].count
        
        let indexPath = IndexPath(row: row, section: section)
        
        allCharacters[section].append(character)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

