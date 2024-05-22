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
        textField.placeholder = "Enter title"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.boldSystemFont(ofSize: 17)
        return textField
    }()

    let detailTextField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = . systemGray6
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.layer.borderWidth = 0.0
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5.0
        return textView
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
            titleTextField.heightAnchor.constraint(equalToConstant: 40),

            detailTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            detailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChanges))
        
        // Add editingChanged target to text fields to update noteTitle and noteDetail
        titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        detailTextField.delegate = self
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        noteTitle = textField.text ?? ""
        print("Title changed to: \(noteTitle)")
    }

    @objc private func saveChanges() {
        guard !noteTitle.isEmpty, !noteDetail.isEmpty else {
            showErrorMessage("Note title and detail can't be empty")
            return
        }
        print("Saving changes with Title: \(noteTitle), Detail: \(noteDetail)")
        delegate?.didEditNoteWithTitle(noteTitle, detail: noteDetail)
        navigationController?.popViewController(animated: true)
    }

    private func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension EditNoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        noteDetail = textView.text
        print("Detail changed to: \(noteDetail)")
    }
}
