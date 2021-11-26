//
//  CreateTableViewCell.swift
//  HabitsTracker
//
//  Created by admin on 28.10.2021.
//

import UIKit

class NameTableViewCell: UITableViewCell {
    
    var delegate: HabitViewController!
    
    let nameTextField: UITextField = {
        let name = UITextField()
        name.placeholder = "К чему будем привыкать?"
   
        return name
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupNameCell()
        nameTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNameCell() {
        contentView.addSubview(nameTextField)
        setupNameCellConstraints()
    }
    
    func setupNameCellConstraints() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
    }
}

extension NameTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate.habit.name = textField.text ?? "default"
        nameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate.habit.name = textField.text ?? "default"
        nameTextField.resignFirstResponder()
    }
}
