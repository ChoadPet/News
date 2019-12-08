//
//  PaginationEntity.swift
//  WorldwideNews
//
//  Created by Vetaliy Poltavets on 12/8/19.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import Foundation

enum UpdateState {
    case processing
    case completed
    case initial
}

final class PaginationEntity {
    let pageSize: Int
    var page: Int
    var updateState: UpdateState
    var ended: Bool
    
    var canMakeRequestForNextPage: Bool {
        return updateState == .initial || updateState == .completed && !ended
    }
    
    init(pageSize: Int, page: Int, updateState: UpdateState = .initial, ended: Bool = false) {
        self.pageSize = pageSize
        self.page = page
        self.updateState = updateState
        self.ended = ended
    }
    
    func didReachEnd(totalResult: Int) {
        ended = page >= totalResult
    }
    
    func incrementPage() {
        page += 1
    }
}
