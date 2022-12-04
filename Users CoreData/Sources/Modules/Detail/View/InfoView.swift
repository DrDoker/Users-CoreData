//
//  InfoView.swift
//  Users CoreData
//
//  Created by Serhii  on 04/12/2022.
//

import UIKit

class InfoView: UIView {
	
	lazy var icon: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	lazy var textField: UITextField = {
		let textField = UITextField()
		textField.backgroundColor = .systemBackground
		textField.layer.cornerRadius = 14
		textField.textAlignment = .center
		textField.isEnabled = false
		return textField
	}()
	
	lazy var lineView: UIView = {
		let view = UIView()
		view.backgroundColor = .systemGray5
		return view
	}()
	
	lazy var stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = 20
		return stack
	}()
	
	//MARK: - Initial
	
	init() {
		super.init(frame: .zero)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	private func commonInit() {
		backgroundColor = .white
		setupHierarchy()
		setupLayout()
	}
	
	// MARK: - Setup
	
	private func setupHierarchy() {
		addSubview(stackView)
		stackView.addArrangedSubview(icon)
		stackView.addArrangedSubview(textField)
		addSubview(lineView)
	}
	
	private func setupLayout() {
		stackView.snp.makeConstraints { make in
			make.top.equalTo(snp.top)
			make.leading.equalTo(snp.leading)
			make.trailing.equalTo(snp.trailing)
			make.height.equalTo(40)
		}
		
		icon.snp.makeConstraints { make in
			make.height.width.equalTo(30)
		}
		
		lineView.snp.makeConstraints { make in
			make.top.equalTo(stackView.snp.bottom).offset(5)
			make.leading.equalTo(snp.leading)
			make.trailing.equalTo(snp.trailing)
			make.bottom.equalTo(snp.bottom)
			make.height.equalTo(1)
		}
	}
}

