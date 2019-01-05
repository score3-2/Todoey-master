//
//  TableVC.swift
//  Todoey
//
//  Created by zero on 8/13/18.
//  Copyright © 2018 zero. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        loadItems(with: request)
    }
    
    
    // MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        // Instance of UIAlert
        var textField = UITextField()
        // New Alert
        let alert = UIAlertController(title: "Add New Todohoy", message: "", preferredStyle: .alert)
        // Anction this start when you press the + button
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // What will happens once the user press the + button
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            // Data Persistance III. This calls the codable Method to save the item.
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // MARK:- NSCodable -- Model Manipulation Methods
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error encoding items array \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Errorfetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
}//



// MARK:- Table View Data Source

extension TodoListViewController {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        // Instance of itemArray . & setting its title as the textLabel on the cell.
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // This checks the cell for a checkMark if the user taps the cell the .checkmark = true. Else = .none
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    
    // MARK:- Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        
        // CheckMark
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        // Diselect Method animation
        tableView.deselectRow(at: indexPath, animated: true)
    }
}//


extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}//
