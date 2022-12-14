//
//  ModuleBuilder.swift
//  Users CoreData
//
//  Created by Serhii  on 01/12/2022.
//

import UIKit

protocol BuilderProtocol {
	func createMainModule(router: RouterProtocol) -> UIViewController
	func createDetailModule(user: User, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: BuilderProtocol {
	
	func createMainModule(router: RouterProtocol) -> UIViewController {
		let view = MainViewController()
		let presenter = MainPresenter(view: view, router: router)
		view.presenter = presenter
		return view
	}
	
	func createDetailModule(user: User, router: RouterProtocol) -> UIViewController {
		let view = DetailViewController()
		let presenter = DetailPresenter(user: user, view: view, router: router)
		view.presenter = presenter
		return view
	}
}
