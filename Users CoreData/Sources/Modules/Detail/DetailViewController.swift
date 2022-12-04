//
//  DetailViewController.swift
//  Users CoreData
//
//  Created by Serhii  on 01/12/2022.
//

import UIKit

class DetailViewController: UIViewController {

	// MARK: - Outlets
	
	// MARK: - Private properties
	
	var presenter: DetailPresenterProtocol?
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView() 
		setupNavBar()
		setupHierarchy()
		setupLayout()
	}
	
	// MARK: - Setup
	
	private func setupView() {
		view.backgroundColor = .systemBackground
	}
	
	private func setupNavBar() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
	}
	
	private func setupHierarchy() {
		
	}
	
	private func setupLayout() {
		
	}
	
	// MARK: - Actions

	@objc func editTapped() {
		
	}
    
}

// MARK: - Extensions

extension DetailViewController: DetailViewProtocol {

}
