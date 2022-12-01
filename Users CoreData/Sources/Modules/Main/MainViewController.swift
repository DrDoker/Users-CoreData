//
//  ViewController.swift
//  Users CoreData
//
//  Created by Serhii  on 01/12/2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
	
	// MARK: - Outlets
	
	lazy var addUserTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Print your name hear"
		textField.backgroundColor = .systemGray6
		textField.layer.cornerRadius = 14
		textField.textAlignment = .center
		return textField
	}()
	
	lazy var addUserButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Press", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		button.tintColor = .white
		button.backgroundColor = .systemBlue
		button.layer.cornerRadius = 14
		
		return button
	}()
	
	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		setupNavBar()
		setupHierarchy()
		setupLayout()
	}
	
	// MARK: - Setup

	private func setupHierarchy() {
		view.addSubview(addUserTextField)
		view.addSubview(addUserButton)
	}

	private func setupLayout() {
		addUserTextField.snp.makeConstraints { make in
			make.top.equalTo(view).offset(150)
			make.left.equalTo(view).offset(16)
			make.right.equalTo(view).offset(-16)
			make.height.equalTo(55)
		}
		
		addUserButton.snp.makeConstraints { make in
			make.top.equalTo(addUserTextField.snp.bottom).offset(20)
			make.left.equalTo(view).offset(16)
			make.right.equalTo(view).offset(-16)
			make.height.equalTo(55)
			
		}
	}
	
	private func setupNavBar() {
		title = "Users"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
}

