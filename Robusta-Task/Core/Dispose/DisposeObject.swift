//
//  DisposeObject.swift
//  Robusta-Task
//
//  Created by Abdelrhman Eliwa on 14/11/2022.
//

import Combine

class DisposeObject {
    var deinitCallBack: (() -> Void)?
    var cancellables: Set<AnyCancellable>
    
    init() {
        self.cancellables = Set<AnyCancellable>()
    }
    
    deinit {
        self.cancellables.removeAll()
        deinitCallBack?()
    }
}
