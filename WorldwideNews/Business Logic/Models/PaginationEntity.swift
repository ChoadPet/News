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
        let b = updateState == .initial || updateState == .completed && !ended
        print("\nCan make request?: \(b)")
        return b
    }
    
    init(pageSize: Int, page: Int, updateState: UpdateState = .initial, ended: Bool = false) {
        self.pageSize = pageSize
        self.page = page
        self.updateState = updateState
        self.ended = ended
    }
    
    func didReachEnd(totalResult: Int) {
        ended = page * pageSize >= totalResult
        print("End: \(ended)")
    }
    
    func incrementPage() {
        page += 1
        print("Increment page: \(page)")
    }
}
