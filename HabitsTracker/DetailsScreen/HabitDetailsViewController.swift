//
//  HabitDetailsViewController.swift
//  HabitsTracker
//
//  Created by admin on 28.10.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    let detailTableView = UITableView(frame: .zero, style: .grouped)
    let detailTVCellID = "detailTVCell"
    
    var habit: Habit!
    var index: Int!
    
    lazy var editBarButton: UIBarButtonItem = {
        let edit = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editButtonAction))
        return edit
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        view.addSubview(detailTableView)
        navigationItem.rightBarButtonItem = editBarButton
        setupTableView()
        setupTableViewConstraints()
    }
    
    func setupTableView() {
        detailTableView.translatesAutoresizingMaskIntoConstraints = false
        detailTableView.dataSource = self
        detailTableView.delegate = self
        detailTableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: detailTVCellID)
    }
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            detailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func editButtonAction() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CreateVC") as? HabitViewController {
            vc.viewControllerState = .edit
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

//MARK: datasourse
extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность".uppercased()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count - 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailTVCellID) as! HabitDetailsTableViewCell
        
        cell.tintColor = .appColour(name: .purple)
        let currentDate = HabitsStore.shared.dates.reversed()[indexPath.row + 1]

        if indexPath.row == 0 {
            cell.dateLabel.text = "Вчера"
        } else if indexPath.row == 1 {
            cell.dateLabel.text = "Позавчера"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy"
            cell.dateLabel.text = dateFormatter.string(from: currentDate)
        }
         
        if HabitsStore.shared.habit(habit, isTrackedIn: currentDate) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}

//MARK: delegate
extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



