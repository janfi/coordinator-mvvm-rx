//
//  MainService.swift
//  coord-mvvm-rx
//
//  Created by JPB-CSI on 25/05/2019.
//  Copyright © 2019 JPB CSI. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol HasMainService {
    var mainService: MainService { get }
}

class MainService {

    let bag = DisposeBag()
    let echo = BehaviorSubject<String>(value:"")
    
    init() {
    }
    
    func doEcho(texte: String)  {
        self.echo.onNext(texte);
    }
}
