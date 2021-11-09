//
//  HabitCollectionViewCell.swift
//  HabitsTracker
//
//  Created by admin on 27.10.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    var habit: Habit? {
        didSet {
            if let habit = habit {
                nameLabel.text = habit.name
                timerLabel.text = habit.dateString
                counterLabel.text = String(habit.trackDates.count)
                circleImageView.image = {
                    if habit.isAlreadyTakenToday {
                        return UIImage(systemName: "circle")
                    } else {
                        return UIImage(systemName: "checkmark.circle.fill")
                    }
                }()
                circleImageView.tintColor = habit.color

            }
        }
    }
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.backgroundColor = .green
        return name
    }()
    
    let timerLabel: UILabel = {
        let timer = UILabel()
        timer.backgroundColor = .blue
        return timer
    }()
    
    let counterLabel: UILabel = {
        let counter = UILabel()
        counter.backgroundColor = .yellow
        return counter
    }()
    
    let circleImageView: UIImageView = {
        let circle = UIImageView()
        circle.backgroundColor = .red
        return circle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHabitCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHabitCell() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(timerLabel)
        contentView.addSubview(counterLabel)
        contentView.addSubview(circleImageView)
        contentView.backgroundColor = .yellow
        contentView.layer.cornerRadius = 8
        setupHabitCellConstraints()
    }
    
    func setupHabitCellConstraints() {
        
        for i in [nameLabel, timerLabel, counterLabel, circleImageView] {
            i.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            timerLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            timerLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            counterLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30),
            counterLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            counterLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            circleImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            circleImageView.widthAnchor.constraint(equalTo: circleImageView.heightAnchor),
            circleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
    }
}
