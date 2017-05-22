//
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation
import CoreData

public class Storage {
    private let entityName = "Article"
    public typealias Entity = _Article
    
    public static let shared = Storage()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!.appendingPathComponent("CoreData.sqlite")
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            abort()
        }
        return coordinator
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "CoreData", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    private init() { }

    //MARK: Objects manipulating
    public func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    public func clear() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? managedObjectContext.execute(deleteRequest)
        saveContext()
    }
    
    public func articlesSortedByDate() -> [Entity] {
        let fetchRequest = NSFetchRequest<Entity>(entityName: entityName)
        let sectionSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        let sortDescriptors = [sectionSortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        let results = try? managedObjectContext.fetch(fetchRequest)
        return results ?? []
    }
    
    public func article(id: Int) -> Entity? {
        let fetchRequest = NSFetchRequest<Entity>(entityName: entityName)
        let description = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)!
        fetchRequest.entity = description
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        let results = try? managedObjectContext.fetch(fetchRequest)
        let object = results?.first
        return object
    }
    
    public func findOrCreateArticle(id: Int) -> Entity {
        if let object = article(id: id) {
            return object
        } else {
            let description = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)!
            let object = Entity(entity: description, insertInto: managedObjectContext)
            object.id = Int32(id)
            return object
        }
    }
    
    public func createArticle(id: Int) -> Entity {
        let description = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)!
        let object = Entity(entity: description, insertInto: managedObjectContext)
        object.id = Int32(id)
        return object
    }
}
