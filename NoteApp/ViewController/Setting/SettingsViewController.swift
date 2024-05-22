import UIKit

class SettingsViewController: UIViewController {
    
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        view.backgroundColor = .white
        
        // Create and setup image view for person icon
        let personIconImageView = UIImageView()
        personIconImageView.image = UIImage(systemName: "person.circle")
        personIconImageView.tintColor = .darkGray
        personIconImageView.contentMode = .scaleAspectFit
        personIconImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(personIconImageView)
        
        // Create and setup label for displaying username
        let usernameLabel = UILabel()
        usernameLabel.text = "Username: \(username ?? "Unknown")"
        usernameLabel.textAlignment = .center
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameLabel)
        
        // Create and setup logout button
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = .red
        logoutButton.layer.cornerRadius = 5
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        view.addSubview(logoutButton)
        
        // Setup constraints for the person icon, username label, and logout button
        NSLayoutConstraint.activate([
            personIconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            personIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personIconImageView.widthAnchor.constraint(equalToConstant: 100),
            personIconImageView.heightAnchor.constraint(equalToConstant: 100),
            
            usernameLabel.topAnchor.constraint(equalTo: personIconImageView.bottomAnchor, constant: 20), // Place under the imageView
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Center horizontally
            usernameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20), // Minimum leading space of 20
            usernameLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20), // Maximum trailing space of -20
            
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 40)
        ])

    }
    
    @objc private func logoutButtonTapped() {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
