//
//  ViewController.swift
//  Todoey
//
//  Created by zed kh on 1/2/19.
//  Copyright © 2019 artech.dz. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category? {
        didSet{
           loadItems()
        }
    }
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        

//        let newItem = Item()
//        newItem.title = "find mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "buy eggos"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "destory demogorgon"
//        itemArray.append(newItem3)

//        loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//
//               itemArray = items
//
//        }
     
        
        

    }


    //MARK - Tableview Datasource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        print("cellForRowAtIdexPath Called")
        // let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoItemCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
        
        cell.textLabel?.text = item.title
        
        //ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        ////////////UP and DOWN lines of codes are the same meaning///////=======>>>>>ternary operator/////////
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else{
//            cell.accessoryType = .none
        }else {
            
            cell.textLabel?.text = "No items added"
        }
        
        return cell
    }
    
       //MARK - tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    
                    realm.delete(item)
                    item.done = !item.done
                }
            } catch{
                
                print("Error saving done status, \(error)")
            }
      
        }
        
        tableView.reloadData()
//        print(itemArray[indexPath.row])
        
//        todoItems[indexPath.row].done = !(todoItems[indexPath.row].done)
//
//        saveItems()
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else{
//            itemArray[indexPath.row].done = false
//        }
//
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//
//        else{ tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
         
    }

   //KARK - ADD NEW ITEMS
    
    
    @IBAction func addButtomPressed(_ sender: UIBarButtonItem) {
        
        var textFeild = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //what will happen once the user clicks the add item button on our UIAlert
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textFeild.text!
                        newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
                }catch{
                    print("Error saving new Items, \(error)")
                }
                    
            }
            
            self.tableView.reloadData()
           
            
//            self.saveItems()
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
//            let encoder = PropertyListEncoder()
//
//            do {
//            let data = try encoder.encode(self.itemArray)
//                try data.write(to: self.dataFilePath!)
//            } catch {
//
//                print("error encoding item array, \(error)")
//            }
//            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextfield) in
            
            alertTextfield.placeholder = "create new item"
            
            textFeild = alertTextfield
            
        }
        
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    
    //MARK - Model Manipulation Methods
    
//    func saveItems() {
//
//
//        do {
//
//           try context.save()
//
//        } catch {
//
//       print("error saving context \(error)")
//        }
//        self.tableView.reloadData()
//    }
    
    
    
    func loadItems() {
        
        todoItems = selectedCategory?.items .sorted(byKeyPath: "title", ascending: true)

//         let categoryPredicate = NSPredicate(format: "presentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//
//            request.predicate = categoryPredicate
//
//        }
//
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//        request.predicate = compoundPredicate
//
//
//        do {
//                itemArray = try context.fetch(request)
//        }
//        catch {
//
//            print("error fetching data from context \(error)")
//        }

        tableView.reloadData()

//        if let data = try? Data(contentsOf: dataFilePath!) {
//            do {
//            let decoder = PropertyListDecoder()
//                itemArray = try decoder.decode([Item].self, from: data)
//            }
//            catch{
//                print("error encoding item array, \(error)")
//            }
//        }
    }


}

// MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate {

func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    todoItems = todoItems?.filter("title CONTAINS [cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
    
    tableView.reloadData()
    
      // ====== THIS METHOD CALLED ONLY WHEN WE NNED TO USE CORE DATA ==============\\

//    let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//   let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//   request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//
//
//    loadItems(with: request, predicate: predicate)

      }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {

            loadItems()

            DispatchQueue.main.async {

                searchBar.resignFirstResponder()
            }

        }
    }



}
