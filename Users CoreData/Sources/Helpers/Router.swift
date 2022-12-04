//
//  Router.swift
//  Users CoreData
//
//  Created by Serhii  on 01/12/2022.
//

import UIKit

protocol RouterMain {
	var navigationController: UINavigationController? { get set }
	var assemblyBuilder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
	func initialViewController()
	func showDetail()
}

class Router: RouterProtocol {
	var navigationController: UINavigationController?
	var assemblyBuilder: BuilderProtocol?
	
	init(navigationController: UINavigationController, assemblyBuilder: BuilderProtocol) {
		self.navigationController = navigationController
		self.assemblyBuilder = assemblyBuilder
	}
	
	func initialViewController() {
		if let navigationController = navigationController {
			guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
			navigationController.viewControllers = [mainViewController]
		}
	}
	
	func showDetail() {
		if let navigationController = navigationController {
			guard let detailViewController = assemblyBuilder?.createDetailModule(router: self) else { return }
			navigationController.pushViewController(detailViewController, animated: true)
		}
	}
}
