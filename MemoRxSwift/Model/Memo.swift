//
//  Memo.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import Foundation

struct Memo: Equatable{
    var content: String
    var insertDate: Date
    var identity: String
    
    init(content: String, insertDate: Date = Date()) {
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    
    //Update시
    init(original: Memo, updatedContent: String) {
        self = original
        self.content = updatedContent
    }
}
