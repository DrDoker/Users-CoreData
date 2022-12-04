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
	
	lazy var usersTable: UITableView = {
		let table = UITableView(frame: .zero, style: .insetGrouped)
		table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		table.delegate = self
		table.dataSource = self
		return table
	}()
	
	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		setupNavBar()
		setupHierarchy()
		setupLayout()
	}
	
	// MARK: - Setup

	private func setupHierarchy() {
		view.addSubview(addUserTextField)
		view.addSubview(addUserButton)
		view.addSubview(usersTable)
	}

	private func setupLayout() {
		addUserTextField.snp.makeConstraints { make in
			make.top.equalTo(view).offset(150)
			make.left.equalTo(view).offset(16)
			make.right.equalTo(view).offset(-16)
			make.height.equalTo(50)
		}
		
		addUserButton.snp.makeConstraints { make in
			make.top.equalTo(addUserTextField.snp.bottom).offset(20)
			make.left.equalTo(view).offset(16)
			make.right.equalTo(view).offset(-16)
			make.height.equalTo(50)
			
		}
		
		usersTable.snp.makeConstraints { make in
			make.top.equalTo(addUserButton.snp.bottom).offset(30)
			make.left.right.equalTo(view)
			make.bottom.equalTo(view)
		}
	}
	
	private func setupNavBar() {
		title = "Users"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		10
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		45
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
		cell.accessoryType = .disclosureIndicator
		cell.textLabel?.text = "User"
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		navigationController?.pushViewController(DetailViewController(), animated: true)
	}
	
}
