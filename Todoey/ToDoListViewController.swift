//
//  ViewController.swift
//  Todoey
//
//  Created by Zhuo Chen on 2018/7/2.
//  Copyright © 2018年 Zhuo Chen. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController : UITableViewController {

    var itemArray = [Item]()
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    var selectedCategory : Category?{
        didSet{
            loadItem()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//    ceshi
//        let newItem1  = Item()
//        newItem1.title = "Find Mike"
//        itemArray.append(newItem1)
//        
//        let newItem2  = Item()
//        newItem2.title = "23333"
//        itemArray.append(newItem2)
//        
//        let newItem3  = Item()
//        newItem3.title = "nono"
//        itemArray.append(newItem3)
        
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
       
        
        
 
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
//            itemArray = items
//        }
    
    }

   
    
    // MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        //Ternary operator  ==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none//改写下面的if else
        
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        
//            context.delete(itemArray[indexPath.row])
//            itemArray.remove(at: indexPath.row)//
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
            // 用下面的方式改写为更简洁   就是当选择那一行一个东西的false等于他的反对面（true）
        
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        }else{
//            itemArray[indexPath.row].done = false
//        }
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{     //table view的cell添加对号
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        saveItem()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    
    
    
    //MARK - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when will user clict add button on uialert
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
            
            
            
            self.saveItem()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    
    }
    
    
    
    
    //MARK - Model Manupulation Methods
    
    func saveItem(){
                                     //        let encoder = PropertyListEncoder()
                                       //   self.defaults.set(self.itemArray, forKey: "ToDoListArray")
        do{
            try context.save()
                                    // let data = try encoder.encode(itemArray)
                                  //  try data.write(to: dataFilePath!)
            
        }catch{
           print("error saving context\(error)")
        }
        self.tableView.reloadData()
        
        
    }
    
    
    func loadItem(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil){ //default value item.fetchrequest()
//        if let data = try? Data(contentsOf: dataFilePath!){。    老方法
//            let decoder = PropertyListDecoder()
//            do{
//                itemArray = try decoder.decode([Item].self, from: data)
//            }catch{
//                print("erreor\(error)")
//            }
//
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)

        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        }
        
//       let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate])
//        request.predicate = compoundPredicate
        
        
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("fetching error\(error)")
        }
        tableView.reloadData()
        
    }
    
    
}
//Mark - SearchBar Methods
extension ToDoListViewController : UISearchBarDelegate{ // 额外的添加 delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!) // %@的值等于searchbar里面输入的值 （searchbar。text）
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItem(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItem()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()//重设定第一反应者
            }
            
        }
    }
}

