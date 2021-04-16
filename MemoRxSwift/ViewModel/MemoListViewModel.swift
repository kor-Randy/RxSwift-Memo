//
//  MemoListViewModel.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import Action
import Foundation
import RxCocoa
import RxSwift

class MemoListViewModel: CommonViewModel {
    var memoList: Observable<[Memo]> {
        return storage.getAll()
    }

    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            self.storage.update(memo: memo, updatedContent: input).map { _ in }
        }
    }
    
    func performCancel(memo: Memo) -> CocoaAction {
        return Action {
            return self.storage.remove(memo: memo).map { _ in }
        }
    }
    
    func makeCreateAction() -> CocoaAction {
        return CocoaAction { _ in
            self.storage.create(content: "")
                .flatMap { memo -> Observable<Void> in
                    let composeViewModel = MemoComposeViewModel(title: "New Memo", sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: memo), cancelAction: self.performCancel(memo: memo))
                    
                    let composeScene = Scene.compose(composeViewModel)
                    
                    return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map { _ in }
                }
        }
    }
}
