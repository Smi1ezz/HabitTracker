//
//  HabitsViewController.swift
//  HabitsTracker
//
//  Created by admin on 26.10.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    let a1 = Habit(name: "a1", date: NSDate.now, trackDates: [NSDate.now], color: UIColor.appColour(name: .purple))
    
    
    let habitsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let habitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        return habitsCollectionView
    }()
    
    lazy var createBarButton: UIBarButtonItem = {
        let create = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createButtonAction))
        create.tintColor = UIColor.appColour(name: .purple)
        return create
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
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false

    }
    
    private func setupNavigationBar() {
        
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
//        navigationBarAppearance.shadowColor = .init(red: 249, green: 90, blue: 67, alpha: 0.29)
        navigationBarAppearance.shadowColor = .lightGray
        navigationBar?.isTranslucent = false
        navigationBar?.backgroundColor = UIColor(red: 249, green: 249, blue: 249, alpha: 0.94)
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.title = "Сегодня:"

        navigationItem.rightBarButtonItem = createBarButton
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
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CreateViewController") {
            print("ok")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    //end
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
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: habitCellID, for: indexPath) as! HabitCollectionViewCell
            cell.habit = a1
            cell.habit?.color = UIColor.appColour(name: .purple)
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
            return CGSize(width: UIScreen.main.bounds.width - 31, height: 60)
        case 1:
            return CGSize(width: UIScreen.main.bounds.width - 31, height: 130)
        default:
            return CGSize(width: UIScreen.main.bounds.width - 31, height: 90)
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
            print("section \(indexPath.section), item \(indexPath.item)")
        case 1:
            print("section \(indexPath.section), item \(indexPath.item)")
            if let vc = storyboard?.instantiateViewController(withIdentifier: "HabitDetailsViewController") {
                print("ok")
                vc.title = "\(HabitsStore.shared.habits[indexPath.item].name)"
                navigationController?.pushViewController(vc, animated: true)
            }
        default:
            print("section \(indexPath.section), item \(indexPath.item)")
        }
    }
}


