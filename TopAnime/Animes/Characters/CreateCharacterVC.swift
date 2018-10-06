//
//  CreateCharacterViewController.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 10/6/18.
//  Copyright © 2018 mrwash. All rights reserved.
//

import UIKit

protocol CreateCharacterVCDelegate {
    func didAddCharacter(character: Character)
}

class CreateCharacterVC: UIViewController {
    
    var delegate: CreateCharacterVCDelegate?

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
        
        navigationItem.title = "Create Character"
        setupCancelButtonInNavBar()
        setupSaveButtonInNavBar(selector: #selector(handleSaveCharacterAction))
        setupUI()
    }
    
    
    func setupUI(){
        let inputsHolderView = setupInputsHolderView(height: 50)
        
        inputsHolderView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: inputsHolderView.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: inputsHolderView.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        inputsHolderView.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
    }

    @objc func handleSaveCharacterAction() {
        guard let characterName = nameTextField.text else { return }
        let tuple = CoreDataManager.shared.createCharacter(characterName: characterName)
        
        if let error = tuple.1 {
            let alertController = UIAlertController(title: "Error", message: "Error Saving Character \(error.localizedDescription)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            alertController.show(self, sender: self)
        }else{
            dismiss(animated: true) {
                self.delegate?.didAddCharacter(character: tuple.0!)
            }

        }
    }
    
}
