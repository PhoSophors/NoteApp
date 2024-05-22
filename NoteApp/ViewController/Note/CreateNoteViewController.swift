/**
 * Name: Pho Sohpors
 * Date: 22 May 2024
 *
 * Create Note View Controller
 */

import UIKit

// Protocol for handling note creation
protocol CreateNoteDelegate: AnyObject {
    func didCreateNoteWithTitle(_ title: String, detail: String)
}

class CreateNoteViewController: UIViewController {

    weak var delegate: CreateNoteDelegate?

    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter title"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let detailTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.layer.borderWidth = 0.0
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5.0
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create Note"

        view.addSubview(titleTextField)
        view.addSubview(detailTextView)

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            detailTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            detailTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
    }

    @objc private func saveNote() {
        guard let title = titleTextField.text, !title.isEmpty,
              let detail = detailTextView.text, !detail.isEmpty else {
            showErrorMessage("Note title and detail can't be empty")
            return
        }
        delegate?.didCreateNoteWithTitle(title, detail: detail)
        navigationController?.popViewController(animated: true)
    }

    private func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
