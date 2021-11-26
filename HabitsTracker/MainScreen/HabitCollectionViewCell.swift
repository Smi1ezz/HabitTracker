//
//  HabitCollectionViewCell.swift
//  HabitsTracker
//
//  Created by admin on 27.10.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    var delegete: HabitsViewController!
    
    var habit: Habit? {
        didSet {
            if let habit = habit {
                nameLabel.text = habit.name
                timerLabel.text = habit.dateString
                counterLabel.text = String("Счетчик: \(habit.trackDates.count)")
                
                if habit.isAlreadyTakenToday {
                    let img = UIImage(systemName: "checkmark.circle.fill")
                    circleButton.setBackgroundImage(img, for: .normal)
                } else {
                    let img = UIImage(systemName: "circle")
                    circleButton.setBackgroundImage(img, for: .normal)
                }

                circleButton.tintColor = habit.color
                
            }
        }
    }
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.headlineStyle()
        return name
    }()
    
    let timerLabel: UILabel = {
        let timer = UILabel()
        timer.captionStyle()
        return timer
    }()
    
    let counterLabel: UILabel = {
        let counter = UILabel()
        counter.statusFootnoteStyle()
        return counter
    }()
    
    let circleButton: UIButton = {
        let circle = UIButton()
        circle.addTarget(self, action: #selector(circleButtonAction), for: .touchUpInside)
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
        contentView.backgroundColor = .white
        contentView.addSubview(nameLabel)
        contentView.addSubview(timerLabel)
        contentView.addSubview(counterLabel)
        contentView.addSubview(circleButton)
        contentView.layer.cornerRadius = 8
        setupHabitCellConstraints()
    }
    
    func setupHabitCellConstraints() {
        
        for i in [nameLabel, timerLabel, counterLabel, circleButton] {
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
            
            circleButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            circleButton.widthAnchor.constraint(equalTo: circleButton.heightAnchor),
            circleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
    }
    
    @objc func circleButtonAction() {
        if let safehabit = habit {
            guard safehabit.isAlreadyTakenToday == false else {
                safehabit.trackDates.removeLast()
                HabitsStore.shared.save()
                delegete.habitsCollectionView.reloadData()
                return
            }
            HabitsStore.shared.track(safehabit)
            delegete.habitsCollectionView.reloadData()
        }
    }

}
