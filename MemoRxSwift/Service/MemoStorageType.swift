//
//  MemoStorageType.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import Foundation
import RxSwift

protocol MemoStorageType {
    //CRUD 메소드 생성
    
    @discardableResult // 결과값이 필요없는 경우에는 무시할 수 있는 Anotation
    func create(content: String) -> Observable<Memo>
    
    @discardableResult
    func getAll() -> Observable<[Memo]>
    
    @discardableResult
    func update(memo: Memo, updatedContent: String) -> Observable<Memo>
    
    @discardableResult
    func remove(memo: Memo) -> Observable<Memo>
}
