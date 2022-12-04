//
//  CoreDataService.swift
//  Users CoreData
//
//  Created by Serhii  on 01/12/2022.
//

import Foundation
import CoreData

class CoreDataService {
	
	static let shared = CoreDataService()

	private init() {}

	lazy var persistentContainer: NSPersistentContainer = {

		let container = NSPersistentContainer(name: "Users_CoreData")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()

	func saveContext () {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
	
	func fetchUsers() -> [User] {
		var tasks: [User] = []
		let context = persistentContainer.viewContext
		let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
		let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		
		do {
			tasks =  try context.fetch(fetchRequest)
		} catch let error as NSError {
			print(error.localizedDescription)
		}
		return tasks
	}
	
	func addUser(withName name: String) {
		let context = persistentContainer.viewContext
		guard let entity = NSEntityDescription.entity(
			forEntityName: "User",
			in: context
		) else {
			return
		}
		let taskObject = User(entity: entity, insertInto: context)
		taskObject.name = name
		saveContext()
	}
	
	func deletAllUsers() {
		let context = persistentContainer.viewContext
		let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
		
		if let tasks = try? context.fetch(fetchRequest) {
			tasks.forEach { task in
				context.delete(task)
			}
			saveContext()
		}
	}
}
