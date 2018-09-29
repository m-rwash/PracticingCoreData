//
//  CreateAnimeViewController.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 9/29/18.
//  Copyright © 2018 mrwash. All rights reserved.
//

import UIKit

protocol CreateAnimeVCDelegate {
    func didAddAnime(anime: Anime)
}

class CreateAnimeVC: UIViewController {
    
    var delegate: CreateAnimeVCDelegate?
    
    let inputsHolderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.whiteBlueColor
        return view
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.placeholder = "Enter Name"
        return textField
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.text = "Name"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkBlueColor
        navigationItem.title = "Create Anime"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelAction))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveAnimeAction))
        
        setupUI()
    }
    
    @objc func handleSaveAnimeAction(){
        dismiss(animated: true){
            guard let name = self.nameTextField.text else { return }
            let anime = Anime(name: name, type: "Movie", startDate: Date())
            self.delegate?.didAddAnime(anime: anime)
        }
    }
    
    @objc func handleCancelAction(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupUI(){
        view.addSubview(inputsHolderView)
        
        inputsHolderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        inputsHolderView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        inputsHolderView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        inputsHolderView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        inputsHolderView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: nameLabel.superview!.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: nameLabel.superview!.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        inputsHolderView.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nameLabel.superview!.topAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        
    }
    

}
