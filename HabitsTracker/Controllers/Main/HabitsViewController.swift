//
//  HabitsViewController.swift
//  HabitsTracker
//
//  Created by admin on 26.10.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    let habitsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let habitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        habitsCollectionView.backgroundColor = .appColour(name: .grayLight)
        return habitsCollectionView
    }()
    
    lazy var createBarButton: UIBarButtonItem = {
        let create = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createButtonAction))
        return create
    }()
    
    lazy var reloadBarButton: UIBarButtonItem = {
        let reload = UIBarButtonItem(title: "Стереть все", style: .plain, target: self, action: #selector(reloadButtonAction))
        return reload
    }()
    
    let progressCellID = "progressCell"
    let habitCellID = "habitCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(habitsCollectionView)
        setupHabitsCollectionView()
        setupHabitsCVConstraints()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        habitsCollectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    private func setupNavigationBar() {
        //MARK: создание границы навиКонтроллера(линия внизу)
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .lightGray
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        navigationBar?.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.title = "Сегодня"
        navigationItem.rightBarButtonItem = createBarButton
        navigationItem.leftBarButtonItem = reloadBarButton
        
    }
    
    private func setupHabitsCollectionView() {
        habitsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        habitsCollectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: progressCellID)
        habitsCollectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: habitCellID)
        habitsCollectionView.dataSource = self
        habitsCollectionView.delegate = self

    }
    
    private func setupHabitsCVConstraints() {
        NSLayoutConstraint.activate([
            habitsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func createButtonAction() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CreateVC") as? HabitViewController {
            vc.viewControllerState = .create
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func reloadButtonAction() {
        //MARK: функция кнопки для обнуления массива привычек для удобства тестирования
        HabitsStore.shared.habits = []
        habitsCollectionView.reloadData()
    }
}

extension HabitsViewController: UICollectionViewDelegate {
    
}

extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return HabitsStore.shared.habits.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: progressCellID, for: indexPath) as! ProgressCollectionViewCell
            cell.reloadCell()
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: habitCellID, for: indexPath) as! HabitCollectionViewCell
            cell.habit = HabitsStore.shared.habits[indexPath.row]
            cell.delegete = self
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
        
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width - 33, height: 60)
        case 1:
            return CGSize(width: UIScreen.main.bounds.width - 33, height: 130)
        default:
            return CGSize(width: UIScreen.main.bounds.width - 33, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch section {
        case 0:
            return UIEdgeInsets(top: 22, left: 16, bottom: 12, right: 17)
        case 1:
            return UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 17)
        default:
            return UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 17)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return
        case 1:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "HabitDetailsViewController") as? HabitDetailsViewController {
                vc.title = "\(HabitsStore.shared.habits[indexPath.item].name)"
                vc.habit = HabitsStore.shared.habits[indexPath.item]
                vc.index = indexPath.item
                navigationController?.pushViewController(vc, animated: true)
            }
        default:
            print("section \(indexPath.section), item \(indexPath.item)")
        }
    }
}


