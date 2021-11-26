//
//  DateTableViewCell.swift
//  HabitsTracker
//
//  Created by admin on 28.10.2021.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    var delegate: HabitViewController!
    
    let dateTextField: UILabel = {
       let date = UILabel()
        date.text = "В какое время выполняем?"
        
        return date
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        return datePicker
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDateTVCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func changeDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let changedTimeString = formatter.string(from: datePicker.date)
        let textToTextField = "Каждый день в " + changedTimeString
        
        dateTextField.attributedText = textToTextField.attributedStringWithColor([changedTimeString], color: UIColor.appColour(name: .indigo))
        
//        delegate.habit.date = formatter.date(from: changedTimeString) ?? Date()
        delegate.habit.date = datePicker.date
    }
    
    func setupDateTVCell() {
        contentView.addSubview(dateTextField)
        contentView.addSubview(datePicker)
        setupDateTVCellConstraints()

    }
    
    func setupDateTVCellConstraints() {
        for i in [dateTextField, datePicker] {
            i.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            dateTextField.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 7),
            dateTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            datePicker.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 15),
            datePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            datePicker.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
