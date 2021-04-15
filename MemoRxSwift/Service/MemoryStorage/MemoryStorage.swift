//
//  MemoryStorage.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import Foundation
import RxSwift

class MemoryStorage: MemoStorageType{

    private var list = [
        Memo(content: "Hello, RxSwift", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Test Memo", insertDate: Date().addingTimeInterval(-20))
    ]
    
    private lazy var store = BehaviorSubject<[Memo]>(value: list)
    
    @discardableResult
    func create(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        
        store.onNext(list)
        return Observable.just(memo)
    }
    
    @discardableResult
    func getAll() -> Observable<[Memo]> {
        return store
    }
    
    @discardableResult
    func update(memo: Memo, updatedContent: String) -> Observable<Memo> {
        let updatedMemo = Memo(original: memo, updatedContent: updatedContent)
        
        if let index = list.firstIndex(where: { $0 == memo}){
            list.remove(at: index)
            list.insert(updatedMemo, at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(updatedMemo)
    }
    
    @discardableResult
    func remove(memo: Memo) -> Observable<Memo> {
        if let index = list.firstIndex(where: { $0 == memo}){
            list.remove(at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(memo)
    }
    
    
}
