//
//  HabitDetailsTableViewCell.swift
//  HabitsTracker
//
//  Created by admin on 28.10.2021.
//

import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
//    var habit: Habit? {
//        didSet {
//            dateLabel.text = {
//                if habit
//            }()
//        }
//    }
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        return dateLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDetailsCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDetailsCell() {
        contentView.addSubview(dateLabel)
        contentView.backgroundColor = .brown
        setupDetailsCellConstraints()
    }
    
    func setupDetailsCellConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
