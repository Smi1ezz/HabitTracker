//
//  CreateViewController.swift
//  HabitsTracker
//
//  Created by admin on 27.10.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    lazy var habit = Habit(name: "default", date: Date(), color: .orange)
    
    let createTableView = UITableView(frame: .zero, style: .grouped)
    
    lazy var saveBarButton: UIBarButtonItem = {
        let save = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonAction))
        
        return save
    }()
    
    lazy var cancelBarButton: UIBarButtonItem = {
        let cancel = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonAction))
       return cancel
    }()
    
    private let nameTVCellID = "nameTVCellID"
    private let colorTVCellID = "colorTVCellID"
    private let dateTTVCellID = "dateTTVCellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Создать"
        view.addSubview(createTableView)
        createTableView.separatorColor = .white
        createTableView.backgroundColor = .white
        setupTableView()
        setupTableViewConstraints()
        setupNavBar()
        self.hideKeyboard()
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
    
    func setupTableView() {
        createTableView.translatesAutoresizingMaskIntoConstraints = false
        createTableView.register(NameTableViewCell.self, forCellReuseIdentifier: nameTVCellID)
        createTableView.register(ColorTableViewCell.self, forCellReuseIdentifier: colorTVCellID)
        createTableView.register(DateTableViewCell.self, forCellReuseIdentifier: dateTTVCellID)
        createTableView.dataSource = self
        createTableView.delegate = self

    }
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            createTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            createTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            createTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            createTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = saveBarButton
        navigationItem.leftBarButtonItem = cancelBarButton

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
    
    @objc func saveButtonAction() {
        if habit.name != "default" && habit.name != "" && habit.color != .black && habit.date != Date() {
            let newHabit = Habit(name: habit.name,
                                 date: habit.date,
                                 color: habit.color)
            
            let store = HabitsStore.shared
            
            store.habits.append(newHabit)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func cancelButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: datasourse
extension HabitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Название".uppercased()
        case 1:
            return "Цвет".uppercased()
        case 2:
            return "Время".uppercased()
        default:
            return "".uppercased()
        }
    }
    
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
            cell.delegate = self
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: colorTVCellID) as! ColorTableViewCell
            cell.delegate = self
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: dateTTVCellID) as! DateTableViewCell
            cell.delegate = self
                habit.date = cell.datePicker.date
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

//MARK: delegate
extension HabitViewController: UITableViewDelegate {
    
}



