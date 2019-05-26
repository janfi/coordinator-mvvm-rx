//
//  PageFlow.swift
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

class PageFlow: Flow {
    
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
        case .page1:
            return navigatePageScreen()
        case .back:
            return .end(forwardToParentFlowWithStep: AppStep.main)
        default:
            return .none
        }
    }
    
    private func navigatePageScreen() -> FlowContributors {
        
        let pageViewModel = PageViewModel()
        let pageViewController = PageViewController.instantiate(withViewModel: pageViewModel, andServices: self.services)
        
        //self.rootViewController.popToRootViewController(animated: false)
        //self.rootViewController.pushViewController(pageViewController, animated: true)
        //self.rootViewController.present(pageViewController, animated: true)
        //self.rootViewController.dismiss(animated: true)
        self.rootViewController.setViewControllers([pageViewController], animated: true);
        
        return .one(flowContributor: .contribute(withNextPresentable: pageViewController, withNextStepper: pageViewModel))
    }
}

