//
//  CreateTableViewCell.swift
//  HabitsTracker
//
//  Created by admin on 28.10.2021.
//

import UIKit

class NameTableViewCell: UITableViewCell {
    
    private let nameTextField: UITextField = {
        let name = UITextField()
        name.placeholder = "К чему будем привыкать?"
        return name
    }()
    
    var name: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupNameCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNameCell() {
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
        name = self.nameTextField.text
    }

}
