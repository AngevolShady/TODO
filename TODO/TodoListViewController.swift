//
//  ViewController.swift
//  TODO
//
//  Created by li tommy on 2019/4/6.
//  Copyright © 2019 li tommy. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let item = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = item
        }
    }

    let defaults = UserDefaults.standard
    var itemArray = ["购买水杯","吃药","修改密码"]
    
    //MARK: - table view datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    //MARK: - table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "添加一个新的ToDo项目", message: "", preferredStyle: .alert)
        
//        let action = UIAlertAction(title: "添加项目", style: .default) { (action) in
//            print("成功！")
//        }

        let action = UIAlertAction(title: "添加项目", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
            print(textField.text!)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "创建一个新项目..."
//            print(alertTextField.text!)
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    
}
