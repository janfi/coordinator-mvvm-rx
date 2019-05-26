//
//  PageViewModel.swift
//  coord-mvvm-rx
//
//  Created by JPB-CSI on 25/05/2019.
//  Copyright © 2019 JPB CSI. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class PageViewModel: ServicesViewModel, ViewModelType, Stepper {
    
    typealias Services = HasMainService
    var services: Services!
    
    struct Input {
         let toBack: Driver<Void>
    }
    
    struct Output {
        let isloading: Driver<Bool>
        let error: Driver<Error>
    }
    
    
    let bag = DisposeBag()
    var steps = PublishRelay<Step>()
    
    func transform(input: Input) -> Output {
        
        input.toBack
            .drive(onNext: { _ in
                self.steps.accept(AppStep.back);
            })
            .disposed(by: bag)
        
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let isloading = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output(
            isloading:isloading,
            error: errors
        )
    }
}

