//
//  TransitionModel.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import Foundation

enum TransitionStyle{
    case root
    case push
    case modal
}

enum TransitionError: Error{
    case navigationControllerMissing
    case cannotPop
    case unknown
}
