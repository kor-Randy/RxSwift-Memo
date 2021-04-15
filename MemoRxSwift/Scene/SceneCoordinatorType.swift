//
//  SceneCoordinatorType.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    @discardableResult
    func close(animated: Bool) -> Completable
}
