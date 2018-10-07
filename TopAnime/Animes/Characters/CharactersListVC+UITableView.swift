//
//  CharactersListVC+UITableView.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 10/7/18.
//  Copyright © 2018 mrwash. All rights reserved.
//
import UIKit

extension CharactersListVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allCharacters.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.whiteBlueColor
        
        let label = UILabel()
        view.addSubview(label)
        label.backgroundColor = UIColor.whiteBlueColor
        label.text = genders[section]
        label.textColor = UIColor.darkBlueColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCharacters[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let character = allCharacters[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = character.name
        
        if let gender = character.characterInfo?.gender {
            cell.textLabel?.text?.append(" - " + gender)
        }
        
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.lightBlueColor
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }

}
