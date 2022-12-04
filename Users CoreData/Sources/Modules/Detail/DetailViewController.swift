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
	private var genders = ["Male", "Female", "Other"]

	// MARK: - Outlets
	
	lazy var userImage: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "userIcon")
		imageView.tintColor = .systemGray
		return imageView
	}()
	
	lazy var nameIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "person.crop.circle")
		return imageView
	}()
	
	lazy var dateOfBirthIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "calendar")
		return imageView
	}()
	
	lazy var genderIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "person.3.fill")
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.text = presenter?.getName()
		return label
	}()
	
	lazy var nameTextField: UITextField = {
		let textField = UITextField()
		textField.backgroundColor = .systemGray6
		textField.layer.cornerRadius = 14
		textField.textAlignment = .center
		
		return textField
	}()
	
	lazy var dateOfBirthTextField: UITextField = {
		let textField = UITextField()
		textField.backgroundColor = .systemGray6
		textField.layer.cornerRadius = 14
		textField.textAlignment = .left
		
		return textField
	}()
	
	lazy var genderTextField: UITextField = {
		let textField = UITextField()
		textField.backgroundColor = .systemGray6
		textField.layer.cornerRadius = 14
		textField.textAlignment = .left
		
		let genderPicker = UIPickerView()
		genderPicker.delegate = self
		genderPicker.dataSource = self
		textField.inputView = genderPicker
		return textField
	}()
	
	lazy var lineView: UIView = {
		let view = UIView()
		view.backgroundColor = .red
		return view
	}()
	
	lazy var genderStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = 20
		return stack
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
		view.addSubview(userImage)
		view.addSubview(nameLabel)
		view.addSubview(genderStack)
		
		genderStack.addArrangedSubview(genderIcon)
		genderStack.addArrangedSubview(genderTextField)
		
	}
	
	private func setupLayout() {
		
		userImage.snp.makeConstraints { make in
			make.centerX.equalTo(view)
			make.top.equalTo(view).offset(150)
			make.height.width.equalTo(150)
		}
		
		nameLabel.snp.makeConstraints { make in
			make.top.equalTo(userImage.snp.bottom).offset(30)
			make.centerX.equalTo(view)
		}
		
		genderStack.snp.makeConstraints { make in
			make.top.equalTo(nameLabel.snp.bottom).offset(30)
			make.left.equalTo(view).offset(30)
			make.right.equalTo(view).offset(-30)
			make.height.equalTo(50)
		}
		
		genderIcon.snp.makeConstraints { make in
			make.height.width.equalTo(35)
		}
		
		lineView.snp.makeConstraints { make in
			make.height.equalTo(5)
		}
	}
	
	// MARK: - Actions

	@objc func editTapped() {
		
	}
    
}

// MARK: - Extensions

extension DetailViewController: DetailViewProtocol {

}

extension DetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		genders.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return genders[row]
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		genderTextField.text = genders[row]
		genderTextField.resignFirstResponder()
		genderTextField.isEnabled = false
		genderTextField.backgroundColor = .systemBackground
	}
	
}
