//
//  TaskModel.swift
//  ToDoTask
//
//  Created by Pavel on 10.04.23.
//

import Foundation
import RealmSwift

class TaskModel: Object, ObjectKeyIdentifiable, Codable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var text: String
    @Persisted var isDone: Bool = false
}
