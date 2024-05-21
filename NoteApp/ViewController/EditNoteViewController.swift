import UIKit

protocol EditNoteDelegate: AnyObject {
    func didEditNoteWithTitle(_ title: String, detail: String)
}

class EditNoteViewController: UIViewController {

    var noteTitle: String
    var noteDetail: String
    weak var delegate: EditNoteDelegate?

    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let detailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Detail"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    init(noteTitle: String, noteDetail: String) {
        self.noteTitle = noteTitle
        self.noteDetail = noteDetail
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Edit Note"

        titleTextField.text = noteTitle
        detailTextField.text = noteDetail

        view.addSubview(titleTextField)
        view.addSubview(detailTextField)

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            detailTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            detailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChanges))
        
        // Add editingChanged target to text fields to update noteTitle and noteDetail
        titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        detailTextField.addTarget(self, action: #selector(detailTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        noteTitle = textField.text ?? ""
        print("Title changed to: \(noteTitle)")
    }
    
    @objc private func detailTextFieldDidChange(_ textField: UITextField) {
        noteDetail = textField.text ?? ""
        print("Detail changed to: \(noteDetail)")
    }

    @objc private func saveChanges() {
        guard !noteTitle.isEmpty, !noteDetail.isEmpty else {
            navigateToErrorPage(message: "Note title and detail can't be empty")
            return
        }
        print("Saving changes with Title: \(noteTitle), Detail: \(noteDetail)")
        delegate?.didEditNoteWithTitle(noteTitle, detail: noteDetail)
        navigationController?.popViewController(animated: true)
    }

    private func navigateToErrorPage(message: String) {
        let errorViewController = UIViewController()
        errorViewController.view.backgroundColor = .white
        errorViewController.title = "Error"
        
        let errorLabel = UILabel()
        errorLabel.text = message
        errorLabel.textAlignment = .center
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorViewController.view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: errorViewController.view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: errorViewController.view.centerYAnchor)
        ])
        
        navigationController?.pushViewController(errorViewController, animated: true)
    }
}
