//
//  ColourTableViewCell.swift
//  HabitsTracker
//
//  Created by admin on 28.10.2021.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    
    let colorPickerButton: UIButton = {
        let colorPickerButton = UIButton()
        colorPickerButton.layer.cornerRadius = 15
        colorPickerButton.backgroundColor = UIColor.appColour(name: .orange)
        colorPickerButton.addTarget(self, action: #selector(presentColorPickerVC), for: .touchUpInside)
        return colorPickerButton
    }()
    
    var delegate: ActionCellProtocol!
    
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

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func presentColorPickerVC() {
        self.delegate.changeViewController()
//        let colorPickerVC = UIColorPickerViewController()
//        colorPickerVC.delegate = self
//        colorPickerVC.selectedColor = colorPickerButton.backgroundColor ?? .orange
//        colorPickerVC.title = "Выбери цвет"
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let newViewController: UIColorPickerViewController = storyboard.instantiateViewController(withIdentifier: "UIColorPickerViewController") as? UIColorPickerViewController {
//            newViewController.delegate = self
//            newViewController.selectedColor = colorPickerButton.backgroundColor ?? .purple
//            newViewController.present(colorPickerVC, animated: true)
//           }
//        UIApplication.shared.keyWindow?.rootViewController?.present(colorPickerVC, animated: true)

    }
}



