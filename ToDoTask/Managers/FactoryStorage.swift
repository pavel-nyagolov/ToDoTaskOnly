//
//  FactoryStorage.swift
//  ToDoTask
//
//  Created by Pavel on 10.04.23.
//

import Foundation
import RealmSwift

class FactoryStorage {
    static let realm = try! Realm(configuration: realmConfig)
    
    static var realmConfig: Realm.Configuration {
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        config.schemaVersion = 1
        return config
    }
    
    static func addTask(_ task: TaskModel) {
        FactoryStorage.realm.beginWrite()
        FactoryStorage.realm.add(task)
        try? FactoryStorage.realm.commitWrite()
        NotificationCenter.default.post(name: .updateTasks, object: nil)
    }
    
    static func deleteTask(_ task: TaskModel) {
        FactoryStorage.realm.beginWrite()
        FactoryStorage.realm.delete(task)
        try? FactoryStorage.realm.commitWrite()
        NotificationCenter.default.post(name: .updateTasks, object: nil)
    }
    
    static func getTasks() -> [TaskModel]? {
        return Array(FactoryStorage.realm.objects(TaskModel.self).sorted(byKeyPath: "id", ascending: true))
    }
}
