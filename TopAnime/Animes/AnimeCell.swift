//
//  AnimeCell.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 9/30/18.
//  Copyright © 2018 mrwash. All rights reserved.
//

import UIKit

class AnimeCell: UITableViewCell {
    
    let animeImageView: UIImageView = {
        let imageViwe = UIImageView(image: UIImage(named: "default_image"))
        imageViwe.contentMode = .scaleAspectFill
        imageViwe.translatesAutoresizingMaskIntoConstraints = false
        return imageViwe
    }()
    
    let animeAiredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Anime Title"
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.lightBlueColor
        
        addSubview(animeImageView)
        animeImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        animeImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        animeImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        animeImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(animeAiredLabel)
        animeAiredLabel.leftAnchor.constraint(equalTo: animeImageView.rightAnchor, constant: 8).isActive = true
        animeAiredLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        animeAiredLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        animeAiredLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
