//  Created by Kevin Maulana on 23/09/22.

import UIKit

final class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        delegate = self
        setupVCs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Home"
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        draw()
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        let barButtonItem = UIBarButtonItem(title: "", style: .plain, target: .none, action: .none)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        navController.navigationBar.barStyle = .default
        navController.navigationBar.backgroundColor = .gray
        rootViewController.navigationItem.backBarButtonItem = barButtonItem
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .black
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navController.navigationBar.standardAppearance = navBarAppearance
        navController.navigationBar.scrollEdgeAppearance = navBarAppearance
        navController.navigationBar.tintColor = .white
        return navController
    }
    
    private func draw() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath().cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        
        shapeLayer.lineWidth = 1.0
        shapeLayer.strokeColor = UIColor(red: 231 / 255, green: 231 / 255, blue: 240 / 255, alpha: 1).cgColor
        self.tabBar.layer.insertSublayer(shapeLayer, at: 1)
    }
    
    private func createPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        
        let screenWidth = UIScreen.main.bounds.width
        
        path.addLine(to: CGPoint(x: 32.6 / 100 * screenWidth, y: 0))
        path.addLine(to: CGPoint(x: screenWidth, y: 0))
        path.addLine(to: CGPoint(x: screenWidth, y: self.tabBar.bounds.height + safeAreaInset.bottom))
        path.addLine(to: CGPoint(x: 0, y: self.tabBar.bounds.height + safeAreaInset.bottom))
        
        path.close()
        return path
    }
    
    private func setupVCs() {
        viewControllers = [
            createNavController(for: BaseViewController(), title: NSLocalizedString("Home", comment: ""),
                                   image: UIImage(systemName: "house")!),
            createNavController(for: FavoriteListViewController(), title: NSLocalizedString("Favorite", comment: ""),
                                   image: UIImage(systemName: "star.fill")!),
            createNavController(for: ProfileViewController(), title: NSLocalizedString("Profile", comment: ""),
                                   image: UIImage(systemName: "person")!)
        ]
    }
    
}

extension TabBar: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch tabBarController.selectedIndex {
        case 0:
            break
        default:
            break
        }
    }
}
