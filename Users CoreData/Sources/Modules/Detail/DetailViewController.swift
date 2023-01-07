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
	private var isEditEnabled = false
	private let datePicker = UIDatePicker()
	private let dateFormatter = DateFormatter()
	
	// MARK: - Outlets
	
	lazy var addImageButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Edit Image", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
		button.tintColor = .white
		button.backgroundColor = .systemBlue
		button.layer.cornerRadius = 8
		button.addTarget(self, action: #selector(addUserImage), for: .touchUpInside)
		button.isHidden = true
		return button
	}()
	
	lazy var userImage: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "userIcon")
		imageView.tintColor = .systemGray
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 75
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
		
		dateFormatter.dateFormat = "dd.MM.yyyy"
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
		view.addSubview(addImageButton)
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
		
		addImageButton.snp.makeConstraints { make in
			make.centerX.equalTo(view)
			make.top.equalTo(userImage.snp.bottom).offset(12)
			make.height.equalTo(30)
			make.width.equalTo(80)
		}
		
		nameView.snp.makeConstraints { make in
			make.top.equalTo(addImageButton.snp.bottom).offset(14)
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
			
			addImageButton.isHidden = false
			nameView.textField.isEnabled = true
			dateOfBirthView.textField.isEnabled = true
			genderView.textField.isEnabled = true
			
			nameView.textField.backgroundColor = .systemGray6
			dateOfBirthView.textField.backgroundColor = .systemGray6
			genderView.textField.backgroundColor = .systemGray6
		} else {
			navigationItem.rightBarButtonItem?.title = "Edit"
			navigationItem.rightBarButtonItem?.tintColor = .systemBlue
			
			addImageButton.isHidden = true
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
			let dateOfBirth = dateFormatter.date(from: dateOfBirthView.textField.text ?? "")
			let gender = genderView.textField.text
			let userImage = userImage.image?.pngData()
			
			presenter?.updateData(name: name, dateOfBirth: dateOfBirth, gender: gender, image: userImage)
		}
	}
	
	@objc func doneTapped() {
		dateOfBirthView.textField.text = dateFormatter.string(from: datePicker.date)
		self.view.endEditing(true)
	}
	
	@objc func addUserImage() {
		let imagePickerController = UIImagePickerController()
		imagePickerController.allowsEditing = false
		imagePickerController.sourceType = .photoLibrary
		imagePickerController.delegate = self
		present(imagePickerController, animated: true, completion: nil)
	}
}

// MARK: - Extensions DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
	func setupDetailedView(name: String?, dateOfBirth: Date?, gender: String?, image: Data?) {
		if let imageData = image {
			userImage.image = UIImage(data: imageData)
		}
		nameView.textField.text = name
		if let date = dateOfBirth {
			dateOfBirthView.textField.text = dateFormatter.string(from: date)
		}
		genderView.textField.text = gender
	}
}

// MARK: - Extensions GenderPicker

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

// MARK: - Extensions ImagePicker

extension DetailViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
		userImage.image  = tempImage
		self.dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
}
