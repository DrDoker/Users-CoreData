//
//  CoreDataService.swift
//  Users CoreData
//
//  Created by Serhii  on 01/12/2022.
//

import Foundation
import CoreData

class CoreDataService {

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
}
