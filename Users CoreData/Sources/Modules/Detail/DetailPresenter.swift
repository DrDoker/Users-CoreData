//
//  DetailPresenter.swift
//  Users CoreData
//
//  Created by Serhii  on 01/12/2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
	func setupDetailedView(name: String?, dateOfBirth: Date?, gender: String?, image: Data?)
}

protocol DetailPresenterProtocol: AnyObject {
	func setData()
	func updateData(name: String?, dateOfBirth: Date?, gender: String?, image: Data?)
}

class DetailPresenter: DetailPresenterProtocol {
	var user: User
	weak var view: DetailViewProtocol?
	var router: RouterProtocol?

	required init(user: User, view: DetailViewProtocol, router: RouterProtocol) {
		self.user = user
		self.view = view
		self.router = router
	}
	
	func setData() {
		view?.setupDetailedView(name: user.name, dateOfBirth: user.dateOfBirth, gender: user.gender, image: user.image)
	}
	
	func updateData(name: String?, dateOfBirth: Date?, gender: String?, image: Data?) {
		self.user.name = name
		self.user.dateOfBirth = dateOfBirth
		self.user.gender = gender
		self.user.image = image
		CoreDataService.shared.saveContext()
	}

}
