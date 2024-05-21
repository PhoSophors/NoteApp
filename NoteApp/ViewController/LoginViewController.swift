import UIKit

class LoginViewController: UIViewController {

    // Define the UI elements
    let noteIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "note.text") 
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Note App"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let toggleButton = UIButton(type: .custom)
        toggleButton.setImage(UIImage(systemName: "eye"), for: .normal)
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        toggleButton.tintColor = .darkGray
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        textField.rightView = toggleButton
        textField.rightViewMode = .always
        
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add the UI elements to the view
        view.addSubview(noteIconImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        // Setup constraints for the UI elements
        setupConstraints()
    }
    
    // Function to setup constraints
    private func setupConstraints() {
        // Note Icon ImageView constraints
        NSLayoutConstraint.activate([
            noteIconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            noteIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noteIconImageView.widthAnchor.constraint(equalToConstant: 100),
            noteIconImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Welcome Label constraints
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: noteIconImageView.bottomAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        // Username TextField constraints
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Password TextField constraints
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Login Button constraints
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // Action for login button tap
    @objc private func loginButtonTapped() {
        validateCredentials()
    }
    
    // Function to toggle password visibility
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    // Function to validate credentials
    private func validateCredentials() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Username and password can't be empty!")
            return
        }

        if (username == "aditi" || username == "admin" || username == "Aditi" || username == "Admin" ) && password == "2024" {
            // Proceed to the home screen
            navigateToHomeScreen(username: username)
        } else {
            // Show incorrect password alert
            showAlert(message: "Incorrect password!")
        }
    }
    
    // Function to show an alert with a message
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // Function to navigate to the home screen
    private func navigateToHomeScreen(username: String) {
        let homeTabBarController = HomeTabBarController()
        homeTabBarController.username = username
        homeTabBarController.modalPresentationStyle = .fullScreen
        present(homeTabBarController, animated: true, completion: nil)
    }
}
