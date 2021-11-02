//
//  CreateViewController.swift
//  HabitsTracker
//
//  Created by admin on 27.10.2021.
//

import UIKit

class CreateViewController: UIViewController {
    
    let createTableView = UITableView(frame: .zero, style: .grouped)
    
    let nameTVCellID = "nameTVCellID"
    let colorTVCellID = "colorTVCellID"
    let dateTTVCellID = "dateTTVCellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createTableView)
        setupTableView()
        setupTableViewConstraints()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            createTableView.contentInset.bottom = keyboardSize.height
            createTableView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        createTableView.contentInset.bottom = .zero
        createTableView.verticalScrollIndicatorInsets = .zero
    }
    
    func setupTableView() {
        createTableView.translatesAutoresizingMaskIntoConstraints = false
        createTableView.register(NameTableViewCell.self, forCellReuseIdentifier: nameTVCellID)
        createTableView.register(ColorTableViewCell.self, forCellReuseIdentifier: colorTVCellID)
        createTableView.register(DateTableViewCell.self, forCellReuseIdentifier: dateTTVCellID)
        createTableView.dataSource = self
        createTableView.delegate = self
        createTableView.backgroundColor = .cyan

    }
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            createTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            createTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            createTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            createTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: datasourse
extension CreateViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: nameTVCellID) as! NameTableViewCell
            cell.backgroundColor = .orange
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: colorTVCellID) as! ColorTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: dateTTVCellID) as! DateTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
}

//MARK: delegate
extension CreateViewController: UITableViewDelegate {
    
}


