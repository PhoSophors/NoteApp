/**
 * Name: Pho Sohpors
 * Date: 21 May 2024
 *
 * Note Folders View Controller
 */

import UIKit
import SnapKit

class NoteFoldersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var folders: [String] = [] // Array to hold folder names
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Folders"
        view.backgroundColor = .white
        
        // Set up collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FolderCollectionViewCell.self, forCellWithReuseIdentifier: "folderCell")
        view.addSubview(collectionView)
        
        // Set up constraints for collection view
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        // Add navigation bar buttons
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFolder))
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "folderCell", for: indexPath) as! FolderCollectionViewCell
        
        // Configure cell to display folder name
        let folderName = folders[indexPath.item]
        cell.nameLabel.text = folderName
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 4 // 4 items per row with spacing
        return CGSize(width: width, height: width * 1.2) // Adjust height as needed
    }
    
    // MARK: - Folder Management
    @objc private func addFolder() {
        let alertController = UIAlertController(title: "New Folder", message: "Enter folder name", preferredStyle: .alert)
        alertController.addTextField()
        
        let createAction = UIAlertAction(title: "Create", style: .default) { _ in
            guard let folderName = alertController.textFields?.first?.text, !folderName.isEmpty else {
                self.showErrorMessage("Folder name can't be empty")
                return
            }
            self.folders.append(folderName)
            self.collectionView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFolder = folders[indexPath.item]
        let alertController = UIAlertController(title: selectedFolder, message: nil, preferredStyle: .alert)
        
        let viewAction = UIAlertAction(title: "View", style: .default) { _ in
             // Show the contents of the selected folder
             self.viewFolder(at: indexPath)
         }
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { _ in
            self.editFolder(at: indexPath)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.folders.remove(at: indexPath.item)
            self.collectionView.deleteItems(at: [indexPath])
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(viewAction)
        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func viewFolder(at indexPath: IndexPath) {
        // Instantiate and show the contents of the selected folder
        let folderName = folders[indexPath.item]
        let folderDetailVC = FolderDetailViewController(folderName: folderName)
        navigationController?.pushViewController(folderDetailVC, animated: true)
    }
    
    private func editFolder(at indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Edit Folder", message: "Enter new folder name", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = self.folders[indexPath.item]
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let newFolderName = alertController.textFields?.first?.text, !newFolderName.isEmpty else {
                self.showErrorMessage("Folder name can't be empty")
                return
            }
            self.folders[indexPath.item] = newFolderName
            self.collectionView.reloadItems(at: [indexPath])
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
