//
//  MainVc+UITableView.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/2/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

extension MainVC {

     //MARK: - UITableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
     
        let course = postsArray[indexPath.row]
        cell.messageLabel.text = course.body
        cell.messageLabel.numberOfLines = 0
        cell.messageLabel.lineBreakMode = .byWordWrapping
        cell.userId.text = "ID: \(course.id)"

        return cell
    }
    

    //Save Data to Core Data when right-swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {

            let task = postsArray.remove(at: indexPath.row)

            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            PersistenceService.shared.delete(task)
            tableView.endUpdates()
            PersistenceService.shared.save()

            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    

}


