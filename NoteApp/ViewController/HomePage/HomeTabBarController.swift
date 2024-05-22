import UIKit

class HomeTabBarController: UITabBarController {
    
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up Note Folders view controller
        let noteFoldersViewController = NoteFoldersViewController()
        noteFoldersViewController.title = "Folders"
        let noteFoldersNavigationController = UINavigationController(rootViewController: noteFoldersViewController)
        noteFoldersNavigationController.tabBarItem = UITabBarItem(title: "Folders", image: UIImage(systemName: "folder"), tag: 0)
        
        // Set up Settings view controller
        let settingsViewController = SettingsViewController()
        settingsViewController.username = username // Pass the username to settings view controller
        settingsViewController.title = "Settings"
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        
        // Add the view controllers to the tab bar controller
        viewControllers = [noteFoldersNavigationController, settingsNavigationController]
    }
}
