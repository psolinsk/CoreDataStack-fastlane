//
//  UserDetailsVC.swift
//  CoreDataStack
//

import UIKit
import CoreData

class UserDetailsVC: UITableViewController {
    
    var managedContext: NSManagedObjectContext!
    
    var currentUser: User?
    
    var userId: Int64?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()
        
    }
    
    /// Za pomocą tej funkcji dodajemy przysmaki dla naszego użytkownika.
    
    @IBAction func addSnack(_ sender: UIBarButtonItem) {
        
        let snack = Snack(context: managedContext)
        snack.name = "Mniam mniam"
        
        // Relacje w Core Data określane są za pomocą obiektów NSSet (w naszym przypadku NSOrderedSet, ponieważ taką opcję wybraślimy tworząc naszą relację). Obiektów tych domyślnie nie można edytować (są 'immutable'). Jeżeli chcemy więc dokonać na nich jakiekolwiek operacje to musimy najpierw uzyskać ich kopię otwartą na edycję.
        
        if let user = currentUser,
            let snacks = user.snacks?.mutableCopy()
                as? NSMutableOrderedSet {
            snacks.add(snack)
            user.snacks = snacks
        }
        
        do {
            
            try managedContext.save()
            
        } catch let error as NSError {
            
            print("Save error: \(error) description: \(error.userInfo)")
        }
                
        tableView.reloadData()
        
    }
    
    /// Funkcja do pobierania z bazy użytkownika na podstawie id przekazanego z MainVC.
    
    func fetchUser() {
        
        guard let id = userId else {
            return
        }
        
        let userFetch: NSFetchRequest<User> = User.fetchRequest()
        
        userFetch.predicate = NSPredicate(format: "%K == %d", #keyPath(User.id), id)
        
        do {
            
            let results = try managedContext.fetch(userFetch)
            
            if let firstResult = results.first {
                
                currentUser = firstResult
                
            }
            
        } catch let error as NSError {
            
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
    }
}

extension UserDetailsVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let snacks = currentUser?.snacks else {
            return 0
        }
        
        return snacks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let snack = currentUser?.snacks?[indexPath.row] as? Snack else {
            return SnackCell()
        }
        
        guard let snackCell = tableView.dequeueReusableCell(withIdentifier: "SnackCell", for: indexPath) as? SnackCell else {
            
            return SnackCell()
            
        }
        
        snackCell.snackName.text = snack.name
        
        return snackCell
        
    }
}
