//
//  EditViewController.swift
//  HabitsTracker
//
//  Created by admin on 08.11.2021.
//

import UIKit

class EditViewController: UIViewController {
    
    var delegate: HabitDetailsViewController!
    
    lazy var delegateHabit = delegate.habit
    
    lazy var habit = Habit(name: delegateHabit?.name ?? "default", date: delegateHabit?.date ?? Date(), trackDates: delegateHabit?.trackDates ?? [], color: delegateHabit?.color ?? .black)
    
    let editTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        return table
    }()
    
    lazy var saveBarButton: UIBarButtonItem = {
        let save = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonAction))
        return save
    }()
    
    lazy var cancelBarButton: UIBarButtonItem = {
        let cancel = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonAction))
       return cancel
    }()
    
    private let nameTVCellID = "NameTableViewCell"
    private let colorTVCellID = "ColorTableViewCell"
    private let dateTVCellID = "DateTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(editTableView)
        navigationItem.largeTitleDisplayMode = .never
        setupTableView()
        setupConstraints()
        setupNaviBar()
        self.hideKeyboard()
    }
    
    private func setupTableView() {
        editTableView.translatesAutoresizingMaskIntoConstraints = false
        editTableView.dataSource = self
        editTableView.delegate = self
        editTableView.register(NameEditTableViewCell.self, forCellReuseIdentifier: nameTVCellID)
        editTableView.register(ColorEditTableViewCell.self, forCellReuseIdentifier: colorTVCellID)
        editTableView.register(DateEditTableViewCell.self, forCellReuseIdentifier: dateTVCellID)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            editTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNaviBar() {
        navigationItem.rightBarButtonItem = saveBarButton
        navigationItem.leftBarButtonItem = cancelBarButton
    }
    
    @objc func saveButtonAction() {
        
        delegate.habit.name = habit.name
        delegate.habit.color = habit.color
        delegate.habit.date = habit.date
        delegate.detailTableView.reloadData()
        HabitsStore.shared.save()
        delegate.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @objc func cancelButtonAction() {
        delegate.navigationController?.popToRootViewController(animated: true)
    }
}

//MARK: datasource
extension EditViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: nameTVCellID, for: indexPath) as! NameEditTableViewCell
            cell.nameTextField.text = habit.name
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: colorTVCellID, for: indexPath) as! ColorEditTableViewCell
            cell.colorPickerButton.backgroundColor = habit.color
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: dateTVCellID, for: indexPath) as! DateEditTableViewCell
            cell.delegate = self
            cell.datePicker.date = habit.date
            cell.changeDate()
            
            return cell
        default:
            return UITableViewCell()
        }
    }

}

//MARK: delegate
extension EditViewController: UITableViewDelegate {
    
}


