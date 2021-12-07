//
//  InfoViewController.swift
//  HabitsTracker
//
//  Created by admin on 26.10.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    let scroll = UIScrollView()
    
    let container = UIView()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Привычка за 21 день"
        title.titleStyle()
        return title
    }()
    
    let infoText: UILabel = {
        let info = UILabel()
        info.text =
"""
Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.

2. Выдержать 2 дня в прежнем состоянии самоконтроля.

3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.

4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
"""
        info.bodyStyle()
        info.textAlignment = .left
        info.numberOfLines = 0
        return info
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Информация"
        setupScrollView()
        setupConstaraints()
    }
    
    func setupScrollView() {
        view.addSubview(scroll)
        scroll.addSubview(container)
        scroll.showsVerticalScrollIndicator = false
        container.addSubview(titleLabel)
        container.addSubview(infoText)
    }
    
    func setupConstaraints() {
        for i in [container, scroll, titleLabel, infoText] {
            i.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            container.topAnchor.constraint(equalTo: scroll.topAnchor),
            container.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            container.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            infoText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            infoText.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            infoText.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            infoText.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -22)
        ])
    }

}
