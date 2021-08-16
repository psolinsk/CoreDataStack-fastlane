//
//  MainVC.swift
//  CoreDataStack
//

import UIKit
import CoreData

class MainVC: UITableViewController {
    
    var managedContext: NSManagedObjectContext!
    
    private enum Keys: String {
        case currentUserId
    }
    
    var userDefaults : UserDefaults {
        return UserDefaults.standard
    }
    
    var users = [User]()
    
    override func viewDidLoad() {
        
        fetchAllUsers()
        
    }
    
    /// Za pomocą tej funkcji dodajemu naszych testowych użytkowników.
    
    @IBAction func addUser(_ sender: UIBarButtonItem) {
        
        let user = User(context: managedContext)
        user.name = "New user"
        
        let currentUserId = userDefaults.integer(forKey: Keys.currentUserId.rawValue)
        
        let nextUserId = currentUserId + 1
        
        userDefaults.set(nextUserId, forKey: Keys.currentUserId.rawValue)
        
        user.id = Int64(nextUserId)
        
        do {
            
            try managedContext.save()
            
        } catch let error as NSError {
            
            print("Save error: \(error) description: \(error.userInfo)")
        }
        
        fetchAllUsers()
        
        tableView.reloadData()
    }
    
    /// Funkcja do pobierania wszystkich użytkowników z bazy danych.
    
    func fetchAllUsers() {
        
        let userFetch: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            
            users = try managedContext.fetch(userFetch)
            
        } catch let error as NSError {
            
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToUserSnacks" {
            if let userDetailsVC = segue.destination as? UserDetailsVC {
                
                if let userId = sender as? Int64 {
                    userDetailsVC.userId = userId
                    userDetailsVC.managedContext = managedContext
                }
            }
        }
    }
}

extension MainVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[indexPath.row]
        
        guard let userCell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {
            
            return UserCell()
            
        }
        
        userCell.userName.text = user.name
        userCell.userId.text = "\(user.id)"
        
        return userCell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userId = users[indexPath.row].id
        
        performSegue(withIdentifier: "goToUserSnacks", sender: userId)
    }
}
