//
//  ColorTableViewCell.swift
//  HabitsTracker
//
//  Created by admin on 08.11.2021.
//

import UIKit

class ColorEditTableViewCell: UITableViewCell {
    
    var delegate: EditViewController!

    let colorPickerButton: UIButton = {
        let colorPickerButton = UIButton()
        colorPickerButton.layer.cornerRadius = 15
        colorPickerButton.backgroundColor = UIColor.appColour(name: .orange)
        colorPickerButton.addTarget(self, action: #selector(presentColorPickerVC), for: .touchUpInside)
        return colorPickerButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupColorTVCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupColorTVCell() {
        contentView.addSubview(colorPickerButton)
        setupColorTVCellConstraints()
    }
    
    func setupColorTVCellConstraints() {
        colorPickerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorPickerButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorPickerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            colorPickerButton.heightAnchor.constraint(equalToConstant: 30),
            colorPickerButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    @objc func presentColorPickerVC() {

        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        colorPickerVC.selectedColor = colorPickerButton.backgroundColor ?? .orange
        colorPickerVC.title = "Выбери цвет"
        
        delegate.present(colorPickerVC, animated: true)
    }
}

//MARK: UIColorPicker delegte
extension ColorEditTableViewCell: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorPickerButton.backgroundColor = viewController.selectedColor
        delegate.habit.color = viewController.selectedColor
    }
}
