import UIKit
import SnapKit

class HomeScreenViewController: UIViewController {
    
    // Custom menu bar
    let menuBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // Container view to hold content views
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color
        view.backgroundColor = .white
        self.title = "Note"
        
        // Add container view to the main view
        view.addSubview(containerView)
        
        // Add menu bar to the view
        view.addSubview(menuBar)
        
        // Set up constraints for the container view
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(menuBar.snp.top)
        }
        
        // Set up constraints for the menu bar
        menuBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(70) // Adjust height as needed
        }
        
        // Add buttons to the menu bar
        let buttonWidth = view.frame.width / 3 // Three buttons for menu bar
        let button1 = createButton(title: "Note", imageName: "note.text", tag: 0, width: buttonWidth)
        let button2 = createButton(title: "Setting", imageName: "gearshape", tag: 1, width: buttonWidth)
        let button3 = createButton(title: "Folders", imageName: "folder", tag: 2, width: buttonWidth)
        
        menuBar.addSubview(button1)
        menuBar.addSubview(button2)
        menuBar.addSubview(button3)
        
        // Set up constraints for buttons
        button1.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(buttonWidth)
        }
        
        button2.snp.makeConstraints { make in
            make.leading.equalTo(button1.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(buttonWidth)
        }
        
        button3.snp.makeConstraints { make in
            make.leading.equalTo(button2.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(buttonWidth)
        }
        
        // Load the default home content
        loadHomeContent()
    }
    
    // Helper method to create buttons
    private func createButton(title: String, imageName: String, tag: Int, width: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(systemName: imageName), for: .normal) // Set icon image
        button.tag = tag
        button.backgroundColor = .darkGray
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    // Load the default home content
    private func loadHomeContent() {
        let noteFoldersVC = NoteFoldersViewController()
        addChild(noteFoldersVC)
        containerView.addSubview(noteFoldersVC.view)
        noteFoldersVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        noteFoldersVC.didMove(toParent: self)
    }
    
    // Action for button tap
    @objc private func buttonTapped(_ sender: UIButton) {
        // Handle button tap
        switch sender.tag {
        case 0:
            // Show the home content (default page)
            containerView.subviews.forEach { $0.removeFromSuperview() } // Remove all subviews
            loadHomeContent()
        case 1:
            // Instantiate and show the SettingsViewController content
            containerView.subviews.forEach { $0.removeFromSuperview() } // Remove all subviews
            let settingsViewController = SettingsViewController()
            addChild(settingsViewController)
            containerView.addSubview(settingsViewController.view)
            settingsViewController.view.frame = containerView.bounds
            settingsViewController.didMove(toParent: self)
        case 2:
            // Show the folders content
            containerView.subviews.forEach { $0.removeFromSuperview() } // Remove all subviews
            let noteFoldersVC = NoteFoldersViewController()
            addChild(noteFoldersVC)
            containerView.addSubview(noteFoldersVC.view)
            noteFoldersVC.view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            noteFoldersVC.didMove(toParent: self)
        default:
            break
        }
    }
}
