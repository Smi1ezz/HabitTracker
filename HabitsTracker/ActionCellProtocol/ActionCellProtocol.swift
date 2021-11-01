//
//  ActionCellProtocol.swift
//  HabitsTracker
//
//  Created by admin on 01.11.2021.
//

import Foundation

/*
 протокол для создания переходов между viewController'ами из ячеек TableViewCell или CollectionViewCell через создание делегатов. Решает проблему с возникновением ошибки Attempt to present whose view is not in the window hierarchy!
 // 1.
 protocol PlayVideoCellProtocol {
     func playVideoButtonDidSelect()
 }

 class TableViewCell {
 // ...

 // 2.
 var delegate: PlayVideoCellProtocol!

 // 3.
 @IBAction func playVideo(sender: AnyObject) {
     self.delegate.playVideoButtonDidSelect()
 }

 // ...
 }

 class TableViewController: SuperClass, PlayVideoCellProtocol {

 // ...

     // 4.
     func playVideoButtonDidSelect() {
         let viewController = ViewController() // Or however you want to create it.
         self.presentViewController(viewController, animated: true, completion: nil)
     }

     func tableView(tableView: UITableView, cellForRowAtIndexPath: NSIndexPath) -> UITableViewCell {
         //... Your cell configuration

         // 5.
         cell.delegate = self
 
 */
protocol ActionCellProtocol {
    func changeViewController()
}
