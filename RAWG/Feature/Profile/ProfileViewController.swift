//
//  ProfileViewController.swift
//  RAWG
//
//  Created by Kevin Maulana on 23/09/22.
//

import Declayout
import UIKit

final class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewViewModel = DefaultProfileViewViewModel()
    private var contentView = ProfileViewHeader()
    private var imagePicker = UIImagePickerController()
    
    private lazy var scrollView = ScrollViewContainer.make {
        $0.setSpacingBetweenItems(to: 4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        bind()
        viewModel.viewDidLoad()
    }
    
    private func subViews() {
        title = "Profile"
        view.backgroundColor = .clear
        view.addSubview(scrollView)
        imagePicker.delegate = self
        scrollView.addArrangedSubViews([
            contentView
        ])
        layout()
        configureButton()
    }
    
    private func bind() {
        self.viewModel.email.observe(on: self) { [weak self] data in
            self?.setContentMail(with: data)
        }
        
        self.viewModel.name.observe(on: self) { [weak self] data in
            self?.setContentName(with: data)
        }
        
        self.viewModel.state.observe(on: self) { [weak self] data in
            self?.handleState(with: data)
        }
        
        self.viewModel.image.observe(on: self) { [weak self] data in
            self?.setContentProfile(with: data)
        }
    }
    
    private func handleState(with state: BaseViewState) {
        switch state {
        case .loading:
            self.manageLoadingActivity(isLoading: true)
            scrollView.isHidden = true
        case .normal:
            self.manageLoadingActivity(isLoading: false)
            scrollView.isHidden = false
        case .empty:
            break
        }
    }
    
    private func setContentName(with name: String) {
        contentView.setContentName(with: name)
    }
    
    private func setContentMail(with mail: String) {
        contentView.setContentEmail(with: mail)
    }
    
    private func setContentProfile(with image: UIImage) {
        contentView.setContentProfile(with: image)
    }
    
    private func layout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: Padding.double + safeAreaInset.top + Padding.half),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureButton() {
        contentView.selectCallBackEditName = {
            self.editName()
        }
        
        contentView.selectCallBackEditEmail = {
            self.editEmail()
        }
        
        contentView.selectCallBackEditPhoto = {
            self.editPhoto()
        }
    }
    
    @objc func editPhoto() {
        let changePictureActionSheet = UIAlertController(title: "Change Profile Picture", message: "", preferredStyle: .actionSheet)
        let galeriAction = UIAlertAction(title: "Open Galery", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.allowsEditing = true
                self.navigationController?.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        let cameraAction = UIAlertAction(title: "Open Camera", style: .default) { _ in
          if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.navigationController?.present(self.imagePicker, animated: true, completion: nil)
          }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
          if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            self.dismiss(animated: true, completion: nil)
          }
        }
        
        changePictureActionSheet.addAction(cancelAction)
        changePictureActionSheet.addAction(galeriAction)
        changePictureActionSheet.addAction(cameraAction)
        self.present(changePictureActionSheet, animated: true, completion: nil)
    }
    
    private func editName() {
        let vc = ProfileEditViewController()
        vc.state = .name
        vc.delegate = self
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func editEmail() {
        let vc = ProfileEditViewController()
        vc.state = .email
        vc.delegate = self
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: ProfileEditDelegate {
    func getEmail() {
        self.viewModel.retriveEmail(with: ProfileEditForkey.email)
    }
    
    func getName() {
        self.viewModel.retriveName(with: ProfileEditForkey.name)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            viewModel.saveImage(with: pickedImage)
            picker.dismiss(animated: true, completion: nil)
            viewModel.retriveImage()
        }
    }
}
