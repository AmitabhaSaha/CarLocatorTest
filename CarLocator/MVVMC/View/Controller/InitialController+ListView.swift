//
//  InitialController+ListView.swift
//  CarLocator
//
//  Created by Amitabha Saha on 26/09/21.
//

import Foundation
import UIKit.UITableView

extension InitialController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        
        // Configure tableview
        listView.register(CarCell.self, forCellReuseIdentifier: TableConstants.CarListIdentifier)
        listView.register(UINib(nibName: TableConstants.CarListIdentifier, bundle: nil), forCellReuseIdentifier: TableConstants.CarListIdentifier)
        listView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 60, right: 0)
        listView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.cars?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableConstants.CarListIdentifier) as? CarCell {
            cell.delegate = self
            do {
                try cell.configureCell(with: viewModel?.cars?[indexPath.row])
            } catch {
                ErrorHandler.shared.handleApplicaitonError(error: error)
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
