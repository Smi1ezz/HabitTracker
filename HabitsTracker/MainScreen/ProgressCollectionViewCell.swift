//
//  ProgressCollectionViewCell.swift
//  HabitsTracker
//
//  Created by admin on 27.10.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    let motivationLabel: UILabel = {
        let motivation = UILabel()
        motivation.text = {
            return "Все получится"
        }() //хочу сделать, чтобы мотивационный текст менялся или рандомно из нескольких фраз, или в зависимости от прогресса
        motivation.statusFootnoteStyle()
        return motivation
    }()
    
    let percentLabel: UILabel = {
        let percent = UILabel()
        let progressInPersentsString = String(NSString(format: "%.0f", HabitsStore.shared.todayProgress*100)) + "%"
        percent.text = progressInPersentsString
        percent.statusFootnoteStyle()
        return percent
    }()
    
    let progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.tintColor = .appColour(name: .purple)
        progress.progress = HabitsStore.shared.todayProgress
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgressCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProgressCell() {
        reloadInputViews()
        contentView.backgroundColor = .white
        contentView.addSubview(motivationLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(progressBar)
        contentView.layer.cornerRadius = 8
        progressBar.layer.cornerRadius = 5
        setupConstraints()
    }
    
    func setupConstraints() {
        
        let allViews = [motivationLabel, percentLabel, progressBar]
        
        for i in allViews {
            i.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            motivationLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            motivationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            percentLabel.centerYAnchor.constraint(equalTo: motivationLabel.centerYAnchor),
            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            progressBar.topAnchor.constraint(equalTo: motivationLabel.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            progressBar.heightAnchor.constraint(equalToConstant: 7)
        ])
    }
    
}
