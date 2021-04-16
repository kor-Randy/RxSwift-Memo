//
//  MemoComposeViewModel.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import Action
import Foundation
import RxCocoa
import RxSwift

class MemoComposeViewModel: CommonViewModel {
    // MARK: Lifecycle

    init(title: String, content: String? = nil, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType, saveAction: Action<String, Void>?, cancelAction: CocoaAction? = nil) {
        self.content = content
        
        self.saveAction = Action<String, Void> { input in
            if let action = saveAction {
                action.execute(input)
            }
            
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        
        self.cancelAction = CocoaAction{
            if let action = cancelAction{
                action.execute(())
            }
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }

    // MARK: Internal

    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction

    var initialText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: nil)
    }

    // MARK: Private

    private let content: String?
}
