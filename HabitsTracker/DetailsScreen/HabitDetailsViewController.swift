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
    
    lazy var editBarButton: UIBarButtonItem = {
        let edit = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editButtonAction))
        edit.tintColor = UIColor.appColour(name: .purple)
        return edit
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailTableView)
        navigationItem.rightBarButtonItem = editBarButton
        setupTableView()
        setupTableViewConstraints()

    }
    
    @objc func editButtonAction() {
        print("edit")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "EditViewController") {
            print("edit ok")
            navigationController?.pushViewController(vc, animated: true)
        }
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

}

//MARK: datasourse
extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность".uppercased()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailTVCellID) as! HabitDetailsTableViewCell
         
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd.MM.yy"
        cell.dateLabel.text = dateFormatter.string(from: HabitsStore.shared.dates[indexPath.row])
        return cell
    }
}

//MARK: delegate
extension HabitDetailsViewController: UITableViewDelegate {
    
}
