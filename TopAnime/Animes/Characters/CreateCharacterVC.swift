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
    
    var anime: Anime?
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
    
    let birthdateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.placeholder = "MM/DD/YYYY"
        return textField
    }()
    
    let birthdateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.text = "Birthdate"
        return label
    }()
    
    let characterGenderSegmentedControl: UISegmentedControl = {
        let genders = [CharacterGender.Male.rawValue, CharacterGender.Female.rawValue]
        let sc = UISegmentedControl(items: genders)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.tintColor = UIColor.darkBlueColor
        return sc
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
        let inputsHolderView = setupInputsHolderView(height: 150)
        
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
        
        inputsHolderView.addSubview(birthdateLabel)
        birthdateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        birthdateLabel.leftAnchor.constraint(equalTo: inputsHolderView.leftAnchor, constant: 16).isActive = true
        birthdateLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        birthdateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        inputsHolderView.addSubview(birthdateTextField)
        birthdateTextField.topAnchor.constraint(equalTo: birthdateLabel.topAnchor).isActive = true
        birthdateTextField.leftAnchor.constraint(equalTo: birthdateLabel.rightAnchor).isActive = true
        birthdateTextField.rightAnchor.constraint(equalTo: inputsHolderView.rightAnchor).isActive = true
        birthdateTextField.heightAnchor.constraint(equalTo: birthdateLabel.heightAnchor).isActive = true
        
        inputsHolderView.addSubview(characterGenderSegmentedControl)
        characterGenderSegmentedControl.topAnchor.constraint(equalTo: birthdateLabel.bottomAnchor, constant: 0).isActive = true
        characterGenderSegmentedControl.leftAnchor.constraint(equalTo: inputsHolderView.leftAnchor, constant: 16).isActive = true
        characterGenderSegmentedControl.rightAnchor.constraint(equalTo: inputsHolderView.rightAnchor, constant: -16).isActive = true
        characterGenderSegmentedControl.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }

    @objc func handleSaveCharacterAction() {
        guard let characterName = nameTextField.text else { return }
        guard let characterBirthdate = birthdateTextField.text else { return }
        guard let anime = self.anime else { return }
        
        if characterBirthdate.isEmpty{
            //
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        guard let birthdate = dateFormatter.date(from: characterBirthdate) else { return }
        
        guard let gender = characterGenderSegmentedControl.titleForSegment(at: characterGenderSegmentedControl.selectedSegmentIndex) else { return }
        
        let tuple = CoreDataManager.shared.createCharacter(characterName: characterName, characterBirthdate: birthdate, characterGender: gender, anime: anime)
        
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
