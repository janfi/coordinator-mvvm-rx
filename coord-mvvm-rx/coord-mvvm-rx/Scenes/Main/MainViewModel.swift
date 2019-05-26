//
//  MainViewModel.swift
//  coord-mvvm-rx
//
//  Created by JPB-CSI on 25/05/2019.
//  Copyright © 2019 JPB CSI. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class MainViewModel: ServicesViewModel, ViewModelType, Stepper {

    typealias Services = HasMainService
  
    
    struct Input {
        let toPage: Driver<Void>
    }
    
    struct Output {
        let echo: Driver<String>
        let isloading: Driver<Bool>
        let error: Driver<Error>
    }
    
  
    let bag = DisposeBag()
    var steps = PublishRelay<Step>()
    var services: Services! {
        didSet {
                 self.services.mainService.doEcho(texte: "HOME");
        }
    }
    
    func transform(input: Input) -> Output {
        
        input.toPage
            .drive(onNext: { _ in
                self.steps.accept(AppStep.page);
            })
            .disposed(by: bag)
        
        let echoDriver = self.services.mainService.echo.asDriverOnErrorJustComplete()
        
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let isloading = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output(
            echo:echoDriver,
            isloading:isloading,
            error: errors
        )
    }
}
