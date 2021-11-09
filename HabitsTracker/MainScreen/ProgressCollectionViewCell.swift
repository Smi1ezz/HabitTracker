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
        motivation.textColor = UIColor.appColour(name: .sysGray)
        motivation.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        motivation.backgroundColor = .yellow
        return motivation
    }()
    
    let percentLabel: UILabel = {
        let percent = UILabel()
        percent.text = String(NSString(format: "%.0f", HabitsStore.shared.todayProgress))
        percent.textColor = UIColor.appColour(name: .sysGray)
        percent.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        percent.backgroundColor = .black
        return percent
    }()
    
    let progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progress = HabitsStore.shared.todayProgress
        progress.backgroundColor = .blue
        return progress
    }()
    
    func setupProgressCell() {
        contentView.addSubview(motivationLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(progressBar)
        contentView.backgroundColor = .green
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgressCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


/*
 
 /* Footnote */


 position: absolute;
 width: 216px;
 height: 18px;
 left: 12px;
 top: 10px;

 /* Footnote (status) */

 font-family: SF Pro Text;
 font-style: normal;
 font-weight: 600;
 font-size: 13px;
 line-height: 18px;
 /* identical to box height, or 138% */

 letter-spacing: -0.078px;

 /* SystemGray Color */

 color: #8E8E93
 
 */
