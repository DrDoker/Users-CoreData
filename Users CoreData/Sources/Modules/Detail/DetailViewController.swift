//
//  DetailViewController.swift
//  Users CoreData
//
//  Created by Serhii  on 01/12/2022.
//

import UIKit

class DetailViewController: UIViewController {
	
	// MARK: - Properties
	
	var presenter: DetailPresenterProtocol?

	// MARK: - Outlets
	
	lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.text = presenter?.getName()
		return label
	}()
	
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
		view.addSubview(nameLabel)
	}
	
	private func setupLayout() {
		nameLabel.snp.makeConstraints { make in
			make.center.equalTo(view)
		}
	}
	
	// MARK: - Actions

	@objc func editTapped() {
		
	}
    
}

// MARK: - Extensions

extension DetailViewController: DetailViewProtocol {

}
