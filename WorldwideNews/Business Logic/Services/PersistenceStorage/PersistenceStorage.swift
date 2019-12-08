//
//  RealmPersistenceStorage.swift
//  WorldwideNews
//
//  Created by Vetaliy Poltavets on 12/5/19.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import RealmSwift

final class PersistenceStorage<ResultType: Object> {
    
   func write(sequence: Array<ResultType>, update: Realm.UpdatePolicy = .all) {
        do {
            let realm = try! Realm()
            try realm.write {
                realm.add(sequence, update: update)
            }
        } catch {
            debugPrint("failed to write object to realm")
        }
    }
    
    func getObjects<DistinctType: Object>(withPredicate predicate: NSPredicate?, sortedBy keyPath: String? = nil, ascending: Bool = true) -> Array<DistinctType> {
        let realm = try! Realm()
        var results = realm.objects(DistinctType.self)
        
        if let predicate = predicate {
            results = results.filter(predicate)
        }
        
        if let keyPath = keyPath {
            results = results.sorted(byKeyPath: keyPath, ascending: ascending)
        }
        return Array(results)
    }
    
    func removeObjectsOfType<DistinctType: Object>(_ type: DistinctType.Type) {
        do {
            let realm = try! Realm()
            try realm.write {
                let objects = realm.objects(type)
                realm.delete(objects)
            }
        } catch {
            debugPrint("failed  to remove object from realm")
        }
    }
}
