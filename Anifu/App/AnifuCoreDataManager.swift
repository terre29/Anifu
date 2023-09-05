//
//  AnifuCoreDataManager.swift
//  Anifu
//
//  Created by Indocyber on 01/09/23.
//

import Foundation
import CoreData
import UIKit

class AnifuCoreDataManager {
    
    let context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchData() -> [AnifuUser]? {
        do {
           let items = try context.fetch(AnifuUser.fetchRequest())
            return items
        } catch {
            // TODO: Handle fetch user error
            return nil
        }
    }
    
    
    func removeData(_ objectToDelete: NSManagedObject) {
        context.delete(objectToDelete)
        saveDataChanges()
    }
    
    func createInitialModel() {
        let user = AnifuUser(context: context)
        user.name = "Default"
        saveDataChanges()
    }
    
    func saveDataChanges() {
        do {
            try context.save()
        } catch {
            // TODO: Handle Error Save
        }
    }
}
