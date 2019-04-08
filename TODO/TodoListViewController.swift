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
//        if let item = defaults.array(forKey: "ToDoListArray") as? [String] {
//            itemArray = item
        
//        let newItem1 = Item()
//        newItem1.title = "购买水杯"
//        itemArray.append(newItem1)
//
//        let newItem2 = Item()
//        newItem2.title = "吃药"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "修改密码"
//        itemArray.append(newItem3)
        
        print(dataFilePath)
        
        loadItems()
    }

//    let defaults = UserDefaults.standard
    var itemArray = [Item]()
    
    //生成文件地址
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //MARK: - table view datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
//        cell.textLabel?.text = itemArray[indexPath.row]
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].done == false {
            cell.accessoryType = .none
        }else {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    //MARK: - table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }else {
            itemArray[indexPath.row].done = false
        }
        
        self.saveItems()
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        tableView.endUpdates()
        
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
            let newItem = Item()
//            let encoder = PropertyListEncoder()
        
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
//            do {
//                let data = try encoder.encode(self.itemArray)
//                try data.write(to: self.dataFilePath!)
//                print(self.dataFilePath!)
//            }catch {
//                print("编码错误：\(error)")
//            }
            
            
//            self.itemArray.append(textField.text!)
//            self.itemArray.append(newItem)
//            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.saveItems()
            self.tableView.reloadData()
            
            print(textField.text!)
            print(self.itemArray)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "创建一个新项目..."
//            print(alertTextField.text!)
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }catch {
                print("解码item错误！")
            }
        }
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch {
            print("编码错误：\(error)")
        }
    }
}
