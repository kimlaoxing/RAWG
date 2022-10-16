//
//  ProfileViewViewModel.swift
//  RAWG
//
//  Created by Kevin Maulana on 27/09/22.
//

import Foundation
import UIKit

protocol ProfileViewInput {
    func retriveEmail(with forKey: String)
    func retriveName(with forKey: String)
    func saveImage(with image: UIImage)
    func retriveImage()
    func viewDidLoad()
    func toEditName(with delegate: ProfileEditDelegate)
    func toEditEmail(with delegate: ProfileEditDelegate)
}

protocol ProfileViewOutput {
    var state: Observable<BaseViewState> { get }
    var name: Observable<String> { get }
    var email: Observable<String> { get }
    var image: Observable<UIImage> { get }
}

protocol ProfileViewViewModel: ProfileViewInput, ProfileViewOutput {}

final class DefaultProfileViewViewModel: ProfileViewViewModel {
    
    let image: Observable<UIImage> = Observable(UIImage())
    let name: Observable<String> = Observable("")
    let email: Observable<String> = Observable("")
    let state: Observable<BaseViewState> = Observable(.loading)
    
    private let useCase = ProfileViewUseCase()
    private let router: Routes
    
    typealias Routes = EditProfileRoute
    
    init(router: Routes) {
        self.router = router
    }
    
    func viewDidLoad() {
        self.retriveImage()
        self.retriveEmail(with: ProfileEditForkey.email)
        self.retriveName(with: ProfileEditForkey.name)
    }
    
    func retriveEmail(with forKey: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.useCase.retriveEmail(with: forKey) { email in
                self.state.value = .normal
                self.email.value = email
            }
        }
    }
    
    func retriveName(with forKey: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.useCase.retriveName(with: forKey) { name in
                self.state.value = .normal
                self.name.value = name
            }
        }
    }
    
    func saveImage(with image: UIImage) {
        self.useCase.saveImage(with: image)
    }
    
    func retriveImage() {
        self.state.value = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.useCase.retriveImage { data in
                self.state.value = .normal
                self.image.value = data
            }
        }
    }
    
    func toEditName(with delegate: ProfileEditDelegate) {
        self.router.toEditName(delegate)
    }
    
    func toEditEmail(with delegate: ProfileEditDelegate) {
        self.router.toEditEmail(delegate)
    }
}
