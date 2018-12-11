//
//  MainViewModel.swift
//  Schedule
//
//  Created by evanecen on 09/12/2018.
//  Copyright © 2018 evanecen. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

struct SectionViewModel {
    var header: String
    var items: [ScheduleViewModel]
}

extension SectionViewModel: SectionModelType {
    typealias Item = ScheduleViewModel
    
    init(original: SectionViewModel, items: [ScheduleViewModel]) {
        self = original
        self.items = items
    }
}

class MainViewModel {
    let scheduleItems = Variable<[ScheduleViewModel]>([])
    var datasource = RxTableViewSectionedReloadDataSource<SectionViewModel>(configureCell: { (_, _, _, _) in
        fatalError()
    })
    let disposeBag = DisposeBag()
    
    init() {
        Service().loadSchedule().subscribe(onNext: { [weak self] schedules in
            
            var scheduleViewModels = schedules.sorted { $0.start < $1.start }
                .map { ScheduleViewModel.init(with: $0) }
            
            for i in 0..<scheduleViewModels.count-1 {
                guard let prevDate = scheduleViewModels[i].endDate, let nextDate = scheduleViewModels[i+1].startDate else { return }
                if prevDate > nextDate {
                    scheduleViewModels[i].isCollision = true
                    scheduleViewModels[i+1].isCollision = true
                }
            }
            self?.scheduleItems.value = scheduleViewModels
        }, onError: { [weak self] error in
            self?.scheduleItems.value = []
        }).disposed(by: disposeBag)
    }
}
