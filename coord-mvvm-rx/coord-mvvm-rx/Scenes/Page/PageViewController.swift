//
//  PageViewController.swift
//  coord-mvvm-rx
//
//  Created by JPB-CSI on 25/05/2019.
//  Copyright © 2019 JPB CSI. All rights reserved.
//

import Foundation
import Reusable
import RxSwift
import RxCocoa
import RxFlow

class PageViewController: UIViewController, StoryboardBased, ViewModelBased {
    
    var viewModel: PageViewModel!
    @IBOutlet weak var back: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        
        let input = PageViewModel.Input(
            toBack: back.rx.tap.asDriverOnErrorJustComplete()
        )
        
        let output = viewModel.transform(input: input)
    }
}

