//
//  DetailPresenter.swift
//  Users CoreData
//
//  Created by Serhii  on 01/12/2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
	
}

protocol DetailPresenterProtocol: AnyObject {
	func getName() -> String
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
	
	func getName() -> String {
		return user.name ?? ""
	}

}
