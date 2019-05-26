//
//  AppFlow.swift
//  coord-mvvm-rx
//
//  Created by JPB-CSI on 25/05/2019.
//  Copyright © 2019 JPB CSI. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

class AppFlow: Flow {

    private let rootWindow: UIWindow
    private let services: AppServices
    private let bag = DisposeBag()
    
    var root: Presentable {
        return self.rootWindow
    }
    
    init(withWindow window: UIWindow, andServices services: AppServices) {
        self.rootWindow = window
        self.services = services
        
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return FlowContributors.none }
        
        switch step {
        case .main:
            return navigationToMainScreen()
        case .page:
            return navigationToPageScreen()
        default:
            return FlowContributors.none
        }
    }
    
    private func navigationToMainScreen() -> FlowContributors {
        print("APP : navigationToMainScreen")
        
        let mainFlow = MainFlow(withServices: self.services)
        
        Flows.whenReady(flow1: mainFlow) { [unowned self] (root) in
            self.rootWindow.rootViewController = root
        }
        
        return .one(flowContributor:.contribute(withNextPresentable: mainFlow,
                                                 withNextStepper: OneStepper(withSingleStep: AppStep.home)))
    }
    
    private func navigationToPageScreen() -> FlowContributors {
        print("APP : navigationToPageScreen")
        
        let pageFlow = PageFlow(withServices: self.services)
        
        Flows.whenReady(flow1: pageFlow) { [unowned self] (root) in
            self.rootWindow.rootViewController = root
        }
        
        return .one(flowContributor:.contribute(withNextPresentable: pageFlow,
                                           withNextStepper: OneStepper(withSingleStep: AppStep.page1)))
    }
    
    
}

