//
//  ViewController.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 9/29/18.
//  Copyright © 2018 mrwash. All rights reserved.
//

import UIKit

class AnimesListVC: UITableViewController {
    
    var dummyAnimesList = [
        Anime(name: "One Punch Man 2", type: "TV", startDate: Date()),
        Anime(name: "Evangelion: 3.0+1.0", type: "Movie", startDate: Date()),
        Anime(name: "Code Geass: Fukkatsu no Lelouch", type: "Movie", startDate: Date())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.backgroundColor = UIColor.darkBlueColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.tableFooterView = UIView()
        
        navigationItem.title = "Animes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(handleAddNewAnimeAction))
        
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
        return dummyAnimesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = dummyAnimesList[indexPath.row].name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor.lightBlueColor
        return cell
    }
}

extension AnimesListVC: CreateAnimeVCDelegate{
    func didAddAnime(anime: Anime) {
        dummyAnimesList.append(anime)
        tableView.insertRows(at: [IndexPath(row: dummyAnimesList.count-1, section: 0)], with: .automatic)
    }
}
