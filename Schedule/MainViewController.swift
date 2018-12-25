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
import RxDataSources

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainViewModel?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel()
        
        let datasource = RxTableViewSectionedReloadDataSource<SectionViewModel>(configureCell: { (dataSource, tableView, indexPath, viewModel) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath)
            cell.textLabel?.text = viewModel.title
            cell.detailTextLabel?.text = viewModel.timeString
            
            cell.textLabel?.isHighlighted = viewModel.isCollision
            cell.detailTextLabel?.isHighlighted = viewModel.isCollision
            return cell
            
        }, titleForHeaderInSection: { (dataSource, index) in
            return dataSource[index].header
        })
        
        viewModel?.scheduleItems.asObservable()
            .bind(to: tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
    }
}
