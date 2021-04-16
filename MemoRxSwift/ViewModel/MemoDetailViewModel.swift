//
//  MemoDetailViewModel.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import Action
import Foundation
import RxCocoa
import RxSwift

class MemoDetailViewModel: CommonViewModel {
    // MARK: Lifecycle

    init(memo: Memo, title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
        self.memo = memo
        
        contents = BehaviorSubject<[String]>(value: [
            memo.content,
            formatter.string(from: memo.insertDate)
        ])
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }

    // MARK: Internal

    let memo: Memo
    let bag = DisposeBag()
    
    var contents: BehaviorSubject<[String]>
    
    lazy var popAction = CocoaAction { [unowned self] in
        self.sceneCoordinator.close(animated: true).asObservable().map { _ in }
    }

    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            self.storage.update(memo: memo, updatedContent: input)
                .subscribe(onNext: { updated in
                    self.contents.onNext([
                        updated.content,
                        self.formatter.string(from: updated.insertDate)
                    ])
                })
                .disposed(by: self.bag)
            
            return Observable.empty()
        }
    }
    
    func makeEditAction() -> CocoaAction {
        return CocoaAction { _ in
            let composeViewModel = MemoComposeViewModel(title: "Edit Memo", content: self.memo.content, sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: self.memo))
            
            let composeScene = Scene.compose(composeViewModel)
            
            return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map { _ in }
        }
    }

    func makeDeleteAction() -> CocoaAction{
        return Action { input in
            self.storage.remove(memo: self.memo)
            return self.sceneCoordinator.close(animated: true).asObservable().map{ _ in }
        }
    }
    
    // MARK: Private

    private var formatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "Ko_kr")
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }()
}
