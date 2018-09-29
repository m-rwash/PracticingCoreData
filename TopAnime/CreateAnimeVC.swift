//
//  CreateAnimeViewController.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 9/29/18.
//  Copyright © 2018 mrwash. All rights reserved.
//

import UIKit
import CoreData

protocol CreateAnimeVCDelegate {
    func didAddAnime(anime: Anime)
    func didEditAnime(anime: Anime)
}

class CreateAnimeVC: UIViewController {
    
    var anime: Anime? {
        didSet{
            nameTextField.text = anime?.name
            guard let aired = anime?.aired else { return }
            datePicker.date = aired
            guard let imageData = anime?.imageData else { return }
            animeImageView.image = UIImage(data: imageData)
            setupAnimeImageView()
        }
    }
    
    var delegate: CreateAnimeVCDelegate?
    
    let inputsHolderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.whiteBlueColor
        return view
    }()
    
    lazy var animeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "default_image"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectImageAction)))
        return imageView
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
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.datePickerMode = .date
        
        return dp
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = anime == nil ? "Create Anime" : "Edit Anime"
        setupAnimeImageView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkBlueColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveAnimeAction))
        
        setupUI()
    }
    
    @objc func handleSelectImageAction(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleSaveAnimeAction(){
        if(anime == nil){
            createNewAnime()
        }else{
            editAnime()
        }
    }
    
    private func editAnime(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        anime?.name = nameTextField.text
        anime?.aired = datePicker.date
        
        if let image = animeImageView.image {
            let imageData = image.jpegData(compressionQuality: 1.0)
            anime?.imageData = imageData
        }
        
        do{
            try context.save()
            dismiss(animated: true){
                self.delegate?.didEditAnime(anime: self.anime!)
            }
        }catch let error {
            print(error)
        }
    }
    
    private func createNewAnime(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let anime = NSEntityDescription.insertNewObject(forEntityName: "Anime", into: context)
        
        guard let animeName = self.nameTextField.text else { return }
        
        anime.setValue(animeName, forKey: "name")
        anime.setValue(datePicker.date, forKey: "aired")
        
        if let image = animeImageView.image {
            let imageData = image.jpegData(compressionQuality: 1.0)
            anime.setValue(imageData, forKey: "imageData")
        }
        
        do{
            try context.save()
            dismiss(animated: true){
                self.delegate?.didAddAnime(anime: anime as! Anime)
            }
        }catch let error {
            print(error)
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
        inputsHolderView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        inputsHolderView.addSubview(animeImageView)
        animeImageView.topAnchor.constraint(equalTo: inputsHolderView.topAnchor, constant: 8).isActive = true
        animeImageView.centerXAnchor.constraint(equalTo: inputsHolderView.centerXAnchor).isActive = true
        animeImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        animeImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        setupAnimeImageView()

        inputsHolderView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: animeImageView.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: inputsHolderView.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        inputsHolderView.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        
        inputsHolderView.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: inputsHolderView.leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: inputsHolderView.rightAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: inputsHolderView.bottomAnchor).isActive = true
    }
    

    private func setupAnimeImageView(){
        animeImageView.layer.cornerRadius = animeImageView.frame.width / 2
        animeImageView.clipsToBounds = true
        animeImageView.layer.borderColor = UIColor.darkBlueColor.cgColor
        animeImageView.layer.borderWidth = 2
    }
}

extension CreateAnimeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            animeImageView.image = editedImage
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            animeImageView.image = originalImage
        }
        
        setupAnimeImageView()
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
