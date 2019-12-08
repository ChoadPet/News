//
//  RealmPersistenceStorage.swift
//  WorldwideNews
//
//  Created by Vetaliy Poltavets on 12/5/19.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import RealmSwift

protocol Persistanable {
    
    init(dataStack: DataStack)
    
    func write(sequence: [Object], update: Realm.UpdatePolicy)
    func getObjects<DistinctType: Object>(withPredicate predicate: NSPredicate?, sortedBy keyPath: String?, ascending: Bool) -> [DistinctType]
    func removeObjectsOfType<DistinctType: Object>(_ type: DistinctType.Type)
}

final class PersistenceStorage: Persistanable {
    
    private let dataStack: DataStack
    
    init(dataStack: DataStack) {
        self.dataStack = dataStack
    }
    
    func write(sequence: [Object], update: Realm.UpdatePolicy = .all) {
        dataStack.write(sequence: sequence, update: update)
    }
    
    func getObjects<DistinctType: Object>(withPredicate predicate: NSPredicate?, sortedBy keyPath: String? = nil, ascending: Bool = true) -> [DistinctType] {
        return dataStack.getObjects(withPredicate: predicate, sortedBy: keyPath, ascending: ascending)
    }
    
    func removeObjectsOfType<DistinctType: Object>(_ type: DistinctType.Type) {
        dataStack.removeObjectsOfType(type)
    }
}
