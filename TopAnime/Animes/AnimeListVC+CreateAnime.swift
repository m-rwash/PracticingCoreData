//
//  AnimeListVC+CreateAnime.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 9/30/18.
//  Copyright © 2018 mrwash. All rights reserved.
//

import UIKit

extension AnimesListVC: CreateAnimeVCDelegate{
    func didEditAnime(anime: Anime) {
        let row = animes.index(of: anime)
        tableView.reloadRows(at: [IndexPath(row: row!, section: 0)], with: .automatic)
    }
    
    func didAddAnime(anime: Anime) {
        animes.append(anime)
        tableView.insertRows(at: [IndexPath(row: animes.count-1, section: 0)], with: .automatic)
    }
}

