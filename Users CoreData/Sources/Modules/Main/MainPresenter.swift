//
//  MainUsersPresenter.swift
//  Users CoreData
//
//  Created by Serhii  on 01/12/2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
	func reloadTable()
}

protocol MainPresenterProtocol: AnyObject {
	func fetchUsers()
	func numberOfUsers() -> Int
	func addUser(withName name: String)
	func getName(for index: IndexPath) -> String
	func deleteUser(by index: IndexPath)
	func showDetail(forUser index: IndexPath)
}

class MainPresenter: MainPresenterProtocol {
	var users: [User]?
	weak var view: MainViewProtocol?
	var router: RouterProtocol?

	required init(view: MainViewProtocol, router: RouterProtocol) {
		self.view = view
		self.router = router
	}
	
	func fetchUsers() {
		users = CoreDataService.shared.fetchUsers()
		view?.reloadTable()
	}
	
	func numberOfUsers() -> Int {
		return users?.count ?? 0
	}
	
	func addUser(withName name: String) {
		CoreDataService.shared.addUser(withName: name)
		fetchUsers()
	}

	func getName(for index: IndexPath) -> String {
		return users?[index.row].name ?? ""
	}
		
	func deleteUser(by index: IndexPath) {
		guard let user = users?[index.row] else { return }
		CoreDataService.shared.delete(user: user)
		fetchUsers()
	}
	
	func showDetail(forUser index: IndexPath) {
		guard let user = users?[index.row] else { return }
		router?.showDetail(user: user)
	}
}
