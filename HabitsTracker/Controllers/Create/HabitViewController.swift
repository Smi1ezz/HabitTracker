//
//  CreateViewController.swift
//  HabitsTracker
//
//  Created by admin on 06.12.2021.
//

import UIKit

enum HabitViewControllerState {
    case create
    case edit
}

class HabitViewController: UIViewController {
    
    var viewControllerState: HabitViewControllerState = .create
    
    var delegate: HabitDetailsViewController!
    
    lazy var habit: Habit = {
        if viewControllerState == .create {
            habit = Habit(name: "default", date: Date(), color: .orange)
            return habit
        } else {
            var delegateHabit = delegate.habit
                
            habit = Habit(name: delegateHabit?.name ?? "default", date: delegateHabit?.date ?? Date(), trackDates: delegateHabit?.trackDates ?? [], color: delegateHabit?.color ?? .black)
            
            return habit
        }
    }()
       
    let scroll = UIScrollView()
    
    let container = HabitDetailView()

    lazy var saveBarButton: UIBarButtonItem = {
        let save = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonAction))
        
        return save
    }()
    
    lazy var cancelBarButton: UIBarButtonItem = {
        let cancel = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonAction))
       return cancel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewControllerState == .create {
            self.title = "Создать"
        } else {
            self.title = "Править"
        }
        container.setupConstraints()
        container.delegate = self
        setupScrollView()
        setupScrollConstraints()
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
    
    private func setupScrollView() {
        view.addSubview(scroll)
        
        if viewControllerState == .edit {
            container.setupEditState()
        }
        
        scroll.addSubview(container)
        scroll.showsVerticalScrollIndicator = false
    }
    
    private func setupScrollConstraints() {
        scroll.translatesAutoresizingMaskIntoConstraints = false
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
            container.heightAnchor.constraint(equalTo: scroll.heightAnchor)
        ])
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = saveBarButton
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.largeTitleDisplayMode = .never

    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scroll.contentInset.bottom = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scroll.contentInset.bottom = .zero
    }
    
    @objc func saveButtonAction() {
        
        if viewControllerState == .create {
            if habit.name != "default" && habit.name != "" {
                let newHabit = Habit(name: habit.name,
                                     date: habit.date,
                                     color: habit.color)
                
                let store = HabitsStore.shared
                
                store.habits.append(newHabit)
                
                navigationController?.popViewController(animated: true)
            }
        } else {
            if delegate.habit.name != habit.name || delegate.habit.color != habit.color || delegate.habit.date != habit.date {
                
                delegate.habit.name = habit.name
                delegate.habit.color = habit.color
                delegate.habit.date = habit.date
                delegate.detailTableView.reloadData()
                HabitsStore.shared.save()
                delegate.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @objc func cancelButtonAction() {
        navigationController?.popViewController(animated: true)
    }

}

