//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Zhuo Chen on 2018/7/12.
//  Copyright © 2018年 Zhuo Chen. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()   //realm第一次creating可能会fail， 用try！强制建立
    
//    var categories = [Category]()
    var categories : Results<Category>?
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //coredata

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
      
       
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textfield.text!
           
            self.save(with: newCategory)
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textfield = field
            textfield.placeholder = "Add New Category"
        }
        present(alert,animated: true,completion: nil)
    }
    
    //Mark: - tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1 //if categories isn't nil, return categories.count, if it's nil then return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet" ////if categories isn't nil, return categories.count, if it's nil then return this message
        
        return cell
    }
    
    //Mark: - tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    //Mark: - Data Munipulation Methods
    func save(with category : Category){
        
        do{
            //try context.save()    CoreData methods
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    func loadCategories(){
        categories = realm.objects(Category.self)
        tableView.reloadData()
        
        
        
        
        
        
    // let  categories = realm.objects(Category.self)  old way
        
        
        
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        do{
//            categories = try context.fetch(request)                     !!!Core Data method 
//        }catch{
//            print("error \(error)")
//        }
   
    
    
    
    
    }
    
    
    
    
    
    
    
}


















