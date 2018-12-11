//
//  MainViewController.swift
//  Schedule
//
//  Created by evanecen on 09/12/2018.
//  Copyright © 2018 evanecen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainViewModel?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel()
        
        viewModel?.datasource.configureCell = { (datasource, tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath)
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = item.timeString
            
            cell.textLabel?.isHighlighted = item.isCollision
            cell.detailTextLabel?.isHighlighted = item.isCollision
            return cell
        }
        
        viewModel?.datasource.titleForHeaderInSection = { (datasource, index) in
            return datasource[index].header
        }
        
        if let datasource = viewModel?.datasource {
            viewModel?.scheduleItems.asObservable()
                .map { items in
                    return Dictionary(grouping: items, by: { $0.dayString })
                        .compactMap { SectionViewModel(header: $0.key, items: $0.value) }
                        .sorted { $0.header < $1.header }
                }
                .bind(to: tableView.rx.items(dataSource: datasource))
                .disposed(by: disposeBag)
        }
    }
}
