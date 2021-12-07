//
//  HabitDetailView.swift
//  HabitsTracker
//
//  Created by admin on 06.12.2021.
//

import UIKit

class HabitDetailView: UIView {
    
    var delegate: HabitViewController!
    
//    Название
    private let nameTitle: UILabel = {
        let title = UILabel()
        title.text = "название"
        title.footnoteBlackStyle()
        return title
    }()
    
    private let nameTextField: UITextField = {
        let name = UITextField()
        name.placeholder = "К чему будем привыкать?"
        return name
    }()
    
//    Цвет
    private let colorTitle: UILabel = {
        let title = UILabel()
        title.text = "цвет"
        title.footnoteBlackStyle()
        return title
    }()
    
    private let colorPickerButton: UIButton = {
        let colorPickerButton = UIButton()
        colorPickerButton.layer.cornerRadius = 15
        colorPickerButton.backgroundColor = UIColor.appColour(name: .orange)
        colorPickerButton.addTarget(self, action: #selector(presentColorPickerVC), for: .touchUpInside)
        return colorPickerButton
    }()
    
//    Время
    private let dateTitle: UILabel = {
        let title = UILabel()
        title.text = "время"
        title.footnoteBlackStyle()
        return title
    }()
    
    private let dateTextField: UILabel = {
       let date = UILabel()
        date.text = "В какое время выполняем?"
        
        return date
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        return datePicker
    }()
    
    lazy var warningButton: UIButton = {
        let warning = UIButton(type: .system)
        warning.setTitle("Удалить привычку", for: .normal)
        warning.tintColor = .systemRed
        warning.addTarget(self, action: #selector(warningButtonAction), for: .touchUpInside)
        warning.translatesAutoresizingMaskIntoConstraints = false
        return warning
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nameTextField.delegate = self
        nameTextField.becomeFirstResponder()
        for i in [nameTitle, nameTextField, colorTitle, colorPickerButton, dateTitle, dateTextField, datePicker] {
            self.addSubview(i)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        for i in [self, nameTitle, nameTextField, colorTitle, colorPickerButton, dateTitle, dateTextField, datePicker] {
            i.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
   
            nameTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 21),
            nameTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameTextField.topAnchor.constraint(equalTo: nameTitle.bottomAnchor, constant: 7),
            nameTextField.leadingAnchor.constraint(equalTo: nameTitle.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            nameTextField.bottomAnchor.constraint(equalTo: colorTitle.topAnchor, constant: -15),
            colorTitle.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            colorTitle.leadingAnchor.constraint(equalTo: nameTitle.leadingAnchor),
            colorPickerButton.topAnchor.constraint(equalTo: colorTitle.bottomAnchor, constant: 7),
            colorPickerButton.leadingAnchor.constraint(equalTo: nameTitle.leadingAnchor),
            colorPickerButton.heightAnchor.constraint(equalToConstant: 30),
            colorPickerButton.widthAnchor.constraint(equalToConstant: 30),
            dateTitle.topAnchor.constraint(equalTo: colorPickerButton.bottomAnchor, constant: 15),
            dateTitle.leadingAnchor.constraint(equalTo: nameTitle.leadingAnchor),
            dateTextField.topAnchor.constraint(equalTo: dateTitle.bottomAnchor, constant: 7),
            dateTextField.leadingAnchor.constraint(equalTo: nameTitle.leadingAnchor),
            datePicker.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 15),
            datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setupEditState() {
        nameTextField.text = delegate.habit.name
        colorPickerButton.backgroundColor = delegate.habit.color
        datePicker.date = delegate.habit.date
        changeDate()
        self.addSubview(warningButton)
        warningButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            warningButton.topAnchor.constraint(greaterThanOrEqualTo: datePicker.bottomAnchor, constant: 15),
            warningButton.leadingAnchor.constraint(equalTo: nameTitle.leadingAnchor),
            warningButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            warningButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18)
        ])
    }
    
    @objc func presentColorPickerVC() {
        print("colorButtonPressed")

        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        colorPickerVC.selectedColor = colorPickerButton.backgroundColor ?? .orange
        colorPickerVC.title = "Выбери цвет"
        
        delegate.present(colorPickerVC, animated: true)
    }
    
    @objc func changeDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let changedTimeString = formatter.string(from: datePicker.date)
        let textToTextField = "Каждый день в " + changedTimeString
        
        dateTextField.attributedText = textToTextField.attributedStringWithColor([changedTimeString], color: UIColor.appColour(name: .purple))
        delegate.habit.date = datePicker.date
    }
    
    @objc func warningButtonAction() {
        let massage = """
Вы хотите удалить привычку "\(delegate.habit.name)"?
"""
        let alertVC = UIAlertController(title: "Удалить привычку"
, message: massage, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            print("Отмена")
        }
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            HabitsStore.shared.habits.remove(at: self.delegate.delegate.index)
            self.delegate.navigationController?.popToRootViewController(animated: true)
            print("Удалить")
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(deleteAction)
        
        delegate.present(alertVC, animated: true, completion: nil)
    }
}

extension HabitDetailView: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorPickerButton.backgroundColor = viewController.selectedColor
        delegate.habit.color = viewController.selectedColor
    }
}

extension HabitDetailView: UITextFieldDelegate {
        
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
