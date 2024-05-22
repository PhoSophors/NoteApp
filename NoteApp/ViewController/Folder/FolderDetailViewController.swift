import UIKit

class FolderDetailViewController: UIViewController {
    
    var folderName: String
    var notes: [(title: String, detail: String)] = [] // Array to hold notes with titles and details
    
    init(folderName: String) {
        self.folderName = folderName
        super.init(nibName: nil, bundle: nil)
        self.title = folderName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Set up table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "noteCell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Add navigation bar button for adding new notes
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
    }
    
    @objc private func addNote() {
        let createNoteVC = CreateNoteViewController()
        createNoteVC.delegate = self
        navigationController?.pushViewController(createNoteVC, animated: true)
    }
    
    private func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension FolderDetailViewController: UITableViewDataSource, UITableViewDelegate, CreateNoteDelegate, EditNoteDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = notes[indexPath.row]
        let noteDetailVC = NoteDetailViewController(title: selectedNote.title, detail: selectedNote.detail)
        navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    
    // Add swipe actions for edit and delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            self.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            handler(true)
        }
        
        // Edit action
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            let selectedNote = self.notes[indexPath.row]
            let editNoteVC = EditNoteViewController(noteTitle: selectedNote.title, noteDetail: selectedNote.detail)
            editNoteVC.delegate = self
            self.navigationController?.pushViewController(editNoteVC, animated: true)
            handler(true)
        }
        editAction.backgroundColor = .blue
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    // Handle the creation of a new note
    func didCreateNoteWithTitle(_ title: String, detail: String) {
        notes.append((title: title, detail: detail))
        tableView.reloadData()
    }
    
    // Handle the editing of an existing note
    func didEditNoteWithTitle(_ title: String, detail: String) {
        if let selectedIndex = tableView.indexPathForSelectedRow?.row {
            notes[selectedIndex] = (title: title, detail: detail)
            tableView.reloadRows(at: [IndexPath(row: selectedIndex, section: 0)], with: .automatic)
        }
    }
    
}

