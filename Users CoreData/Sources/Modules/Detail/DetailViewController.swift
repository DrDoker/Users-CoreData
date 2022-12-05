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
	
	private var isEditEnabled = false
	private let dateFormatter = DateFormatter()
	private let datePicker = UIDatePicker()
	private var genders = ["Male", "Female", "Other"]

	// MARK: - Outlets
	
	lazy var userImage: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "userIcon")
		imageView.tintColor = .systemGray
		return imageView
	}()
	
	lazy var nameView: InfoView = {
		let view = InfoView()
		view.icon.image = UIImage(systemName: "person.crop.circle")
		view.textField.placeholder = "Name"
		return view
	 }()
	
	lazy var dateOfBirthView: InfoView = {
		let view = InfoView()
		view.icon.image = UIImage(systemName: "calendar")
		view.textField.placeholder = "Data Of Birth"
		
		let toolbar = UIToolbar()
		toolbar.sizeToFit()
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneTapped))
		toolbar.setItems([doneButton], animated: true)
		view.textField.inputAccessoryView = toolbar
		
		datePicker.preferredDatePickerStyle = .wheels
		datePicker.maximumDate = Date()
		datePicker.datePickerMode = .date
		view.textField.inputView = datePicker
		return view
	 }()
	
	lazy var genderView: InfoView = {
		let view = InfoView()
		view.icon.image = UIImage(systemName: "person.3.fill")
		view.textField.placeholder = "Gender"
		
		let genderPicker = UIPickerView()
		genderPicker.delegate = self
		genderPicker.dataSource = self
		view.textField.inputView = genderPicker
		return view
	 }()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView() 
		setupNavBar()
		setupHierarchy()
		setupLayout()
		presenter?.setData()
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
		view.addSubview(nameView)
		view.addSubview(dateOfBirthView)
		view.addSubview(genderView)
	}
	
	private func setupLayout() {
		
		userImage.snp.makeConstraints { make in
			make.centerX.equalTo(view)
			make.top.equalTo(view).offset(150)
			make.height.width.equalTo(150)
		}
		
		nameView.snp.makeConstraints { make in
			make.top.equalTo(userImage.snp.bottom).offset(50)
			make.left.equalTo(view).offset(20)
			make.right.equalTo(view).offset(-20)
		}
		
		dateOfBirthView.snp.makeConstraints { make in
			make.top.equalTo(nameView.snp.bottom).offset(14)
			make.left.equalTo(view).offset(20)
			make.right.equalTo(view).offset(-20)
		}
		
		genderView.snp.makeConstraints { make in
			make.top.equalTo(dateOfBirthView.snp.bottom).offset(14)
			make.left.equalTo(view).offset(20)
			make.right.equalTo(view).offset(-20)
		}
	}
	
	func editIsEnabled() {
		if isEditEnabled {
			navigationItem.rightBarButtonItem?.title = "Save"
			navigationItem.rightBarButtonItem?.tintColor = .systemGreen
			
			nameView.textField.isEnabled = true
			dateOfBirthView.textField.isEnabled = true
			genderView.textField.isEnabled = true
			
			nameView.textField.backgroundColor = .systemGray6
			dateOfBirthView.textField.backgroundColor = .systemGray6
			genderView.textField.backgroundColor = .systemGray6
		} else {
			navigationItem.rightBarButtonItem?.title = "Edit"
			navigationItem.rightBarButtonItem?.tintColor = .systemBlue
			
			nameView.textField.isEnabled = false
			dateOfBirthView.textField.isEnabled = false
			genderView.textField.isEnabled = false
			
			nameView.textField.backgroundColor = .systemBackground
			dateOfBirthView.textField.backgroundColor = .systemBackground
			genderView.textField.backgroundColor = .systemBackground
		}
	}
	
	// MARK: - Actions

	@objc func editTapped() {
		isEditEnabled.toggle()
		editIsEnabled()
		
		if !isEditEnabled {
			let name = nameView.textField.text
			dateFormatter.dateFormat = "dd.MM.yyyy"
			let dateOfBirth = dateFormatter.date(from: dateOfBirthView.textField.text ?? "")
			let gender = genderView.textField.text
			
			presenter?.updateData(name: name, dateOfBirth: dateOfBirth, gender: gender, image: nil)
		}
	}
	
	@objc func doneTapped() {
		dateFormatter.dateFormat = "dd.MM.yyyy"
		dateOfBirthView.textField.text = dateFormatter.string(from: datePicker.date)
		self.view.endEditing(true)
	}
}

// MARK: - Extensions DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
	func setupDetailedView(name: String?, dateOfBirth: Date?, gender: String?, image: Data?) {
		nameView.textField.text = name
		if let date = dateOfBirth {
			dateFormatter.dateFormat = "dd.MM.yyyy"
			dateOfBirthView.textField.text = dateFormatter.string(from: date)
		}
		genderView.textField.text = gender
	}
}

// MARK: - Extensions genderPicker

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
		genderView.textField.text = genders[row]
		genderView.textField.resignFirstResponder()
	}
}
