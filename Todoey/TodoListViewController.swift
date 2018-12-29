//
//  TableVC.swift
//  Todoey
//
//  Created by zero on 8/13/18.
//  Copyright © 2018 zero. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    // Mark: - Properties
    var  itemArray = ["One", "Two", "Three"]
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Actions
    @IBAction func addButtonPressed(_ sender: Any) {
        
        // Instance of UIAlert
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todohoy", message: "", preferredStyle: .alert)
    
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happens once the user press the + button
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }
    
    
   
}



    //MARK:- Table View Data Source
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
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
}



    //MARK:- Table View Delegate
extension TodoListViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        // Checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        // Diselect Method animation
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
