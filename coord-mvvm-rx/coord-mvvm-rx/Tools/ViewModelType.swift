//
//  ViewModelType.swift
//  coord-mvvm-rx
//
//  Created by JPB-CSI on 25/05/2019.
//  Copyright © 2019 JPB CSI. All rights reserved.
//

import Foundation

protocol ViewModelType {
    
    associatedtype Input
    
    associatedtype Output
    
    func transform(input: Input) -> Output
}

