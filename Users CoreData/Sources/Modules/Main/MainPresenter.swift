//
//  MainUsersPresenter.swift
//  Users CoreData
//
//  Created by Serhii  on 01/12/2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
	
}

protocol MainPresenterProtocol: AnyObject {
	func showDetail()
}

class MainPresenter: MainPresenterProtocol {
	weak var view: MainViewProtocol?
	var router: RouterProtocol?

	required init(view: MainViewProtocol, router: RouterProtocol) {
		self.view = view
		self.router = router
	}
	
	func showDetail() {
		router?.showDetail()
	}

}
