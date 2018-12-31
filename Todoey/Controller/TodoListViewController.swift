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
    var  itemArray = [Item]()
    
    // Data Persistance 1
    let defaults = UserDefaults.standard
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "This is a Todo"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "This is a 2 do"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "This is a 3 do"
        itemArray.append(newItem3)
        
        // Data Persistance 3
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
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
            // Instantiate the Item class and then use the text property to add a new item.
            let newItem = Item()
            newItem.title = textField.text!
            newItem.done = true
            self.itemArray.append(newItem)
            
            // This saves user todos 2
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
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
        
        // Instance of itemArray . & setting its title as the textLabel on the cell.
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // This checks the cell for a checkMark if the user taps the cell the .checkmark = true. Else = .none
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
}



    //MARK:- Table View Delegate
extension TodoListViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        // CheckMark
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        
        tableView.reloadData()
        
        // Diselect Method animation
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
