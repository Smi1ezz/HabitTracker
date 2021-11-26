//
//  NameTableViewCell.swift
//  HabitsTracker
//
//  Created by admin on 08.11.2021.
//

import UIKit

class NameEditTableViewCell: UITableViewCell {
    
    var delegate: EditViewController!
    
    let nameTextField: UITextField = {
        let name = UITextField()
        name.placeholder = "К чему будем привыкать?"
        
        return name
    }()
    
    var name: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupNameCell()
        self.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNameCell() {
        nameTextField.delegate = self
        contentView.addSubview(nameTextField)
        contentView.backgroundColor = .cyan
        setupNameCellConstraints()
    }
    
    func setupNameCellConstraints() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

//MARK: textfield delegate func
extension NameEditTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate.habit.name = nameTextField.text ?? "name from EditVC Return"
        nameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate.habit.name = nameTextField.text ?? "name from EditVC didEnd"
        nameTextField.resignFirstResponder()
    }
}

