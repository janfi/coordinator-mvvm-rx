//
//  MainFlow.swift
//  coord-mvvm-rx
//
//  Created by JPB-CSI on 25/05/2019.
//  Copyright © 2019 JPB CSI. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import UIKit

class MainFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()
    private let services: AppServices
    private let bag = DisposeBag()
    private let profileRootViewController = UINavigationController()
    
    private var presentedController: UIViewController?
    
    init(withServices services: AppServices) {
        self.services = services
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        
        guard let step = step as? AppStep else { return FlowContributors.none }
        
        switch step {
        case .home:
            return navigateHomeScreen()
        case .page:
            return .end(forwardToParentFlowWithStep: AppStep.page)
        default:
            return .none
        }
    }
    
    private func navigateHomeScreen() -> FlowContributors {
        
        let mainViewModel = MainViewModel()
        let mainViewController = MainViewController.instantiate(withViewModel: mainViewModel, andServices: self.services)
        
        //self.rootViewController.popToRootViewController(animated: false)
        //self.rootViewController.pushViewController(pageViewController, animated: true)
        //self.rootViewController.present(pageViewController, animated: true)
        //self.rootViewController.dismiss(animated: true)
        self.rootViewController.setViewControllers([mainViewController], animated: true);
        
        return .one(flowContributor: .contribute(withNextPresentable: mainViewController, withNextStepper: mainViewModel))
    }
}

