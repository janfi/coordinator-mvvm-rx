//
//  MainViewController.swift
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

class MainViewController: UIViewController, StoryboardBased, ViewModelBased {
    
    var viewModel: MainViewModel!
    let bag = DisposeBag()
    
    @IBOutlet weak var toPage1: UIButton!
    @IBOutlet weak var lblEcho: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        
        let input = MainViewModel.Input(
            toPage: toPage1.rx.tap.asDriverOnErrorJustComplete()
        )
        
        let output = viewModel.transform(input: input)
        
        output.echo
            .asObservable()
            .map { $0 }
            .bind(to:self.lblEcho.rx.text)
            .disposed(by:self.bag)

    }
    

}
