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
        self.characters.append(character)
        self.tableView.insertRows(at: [IndexPath(row: characters.count - 1, section: 0)], with: .automatic)
    }
}

