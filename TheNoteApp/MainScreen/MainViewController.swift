//
//  MainViewController.swift
//  TheNoteApp
//
//  Created by Neskin Ivan on 17.03.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items = [TheNoteListItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTable()
        getItems()
    }
    
    // MARK: - Navigation bar
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Заметки"
        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 35, green: 138, blue: 227)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
    }
    
    @objc func addNewNote() {
        showAlertAdd()
    }
    
    // MARK: - Table view data source
    
    private func setupTable() {
        tableView.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.reuseId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.reuseId, for: indexPath) as! MainViewCell
        let item = items[indexPath.row]
        cell.configureWith(title: item.title!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "", handler: {a,b,c in
            self.deleteNote(item: self.items[indexPath.row])
            
            if self.items.isEmpty {
                tableView.isHidden = true
            } else {
                tableView.isHidden = false
            }
        })
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        showEditAlert(currentItem: item)
    }
}

extension MainViewController {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getItems() {
        
        do {
            items = try context.fetch(TheNoteListItem.fetchRequest())
            reloadData()
        }catch {
            print("error")
        }
    }
}

extension MainViewController {
    func deleteNote(item: TheNoteListItem) {
        context.delete(item)
        
        do {
            try context.save()
            getItems()
        } catch {
            
        }
    }
    
    func updateNote(item: TheNoteListItem, newTitle: String) {
        item.title = newTitle
        
        do {
            try context.save()
            getItems()
        } catch {
            
        }
    }
    
    func createNote(title: String) {
        let newNote = TheNoteListItem(context: context)
        newNote.title = title
        do {
            try context.save()
            getItems()
        } catch {
            
        }
    }
}

extension MainViewController {
    func showAlertAdd() {
        let alertController = UIAlertController(title: "The note", message: "Enter new note", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { _ in
            guard let field = alertController.textFields?.first, let text = field.text, !text.isEmpty else { return }
            self.createNote(title: text)
        }))
        present(alertController, animated: true)
    }
    
    func showEditAlert(currentItem: TheNoteListItem) {
        let actionSheetController = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        actionSheetController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheetController.addAction(UIAlertAction(title: "Редактировать", style: .default, handler: { _ in
            self.editAlert(currentItem: currentItem)
        }))
        actionSheetController.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            self.deleteNote(item: currentItem)
        }))
        
        present(actionSheetController, animated: true)
    }
    
    func editAlert(currentItem: TheNoteListItem) {
        let alertController = UIAlertController(title: "The note", message: "Enter new note", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.textFields?.first?.text = currentItem.title
        alertController.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { _ in
            guard let field = alertController.textFields?.first, let newTitle = field.text, !newTitle.isEmpty else { return }
            self.updateNote(item: currentItem, newTitle: newTitle)
        }))
        present(alertController, animated: true)
    }
}
