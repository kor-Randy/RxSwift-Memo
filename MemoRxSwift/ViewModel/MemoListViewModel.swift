//
//  MemoListViewModel.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import Foundation
import RxCocoa
import RxSwift

class MemoListViewModel: CommonViewModel{
    var memoList: Observable<[Memo]>{
        return storage.getAll()
    }
}
