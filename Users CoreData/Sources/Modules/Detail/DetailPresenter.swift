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

}

class DetailPresenter: DetailPresenterProtocol {
	weak var view: DetailViewProtocol?
	var router: RouterProtocol?

	required init(view: DetailViewProtocol, router: RouterProtocol) {
		self.view = view
		self.router = router
	}

}
