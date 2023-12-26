//
//  PlayListItem.swift
//  YouTubeListPlayApp_PromiseKit
//
//  Created by Ajit Satarkar on 26/12/23.
//

import Foundation

protocol Todo {
    var userId: Int { get }
    var id: Int { get }
    var title: String { get }
    var completed: Bool { get }
}


struct TodoItem: Todo, Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}
