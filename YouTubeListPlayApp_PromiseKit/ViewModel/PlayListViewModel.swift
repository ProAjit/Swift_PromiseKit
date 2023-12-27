//
//  PlayListViewModel.swift
//  YouTubeListPlayApp_PromiseKit
//
//  Created by Ajit Satarkar on 26/12/23.
//

import Foundation
import PromiseKit

protocol TodoViewModelProtocol {
    var todos: [Todo] { get }
    var isLoading: Bool { get set }
    func fetchData() -> Promise<[TodoItem]>
}

class TodoViewModel: TodoViewModelProtocol {
    
    var todos: [Todo] = []
    var isLoading: Bool = false

    func fetchData() -> Promise<[TodoItem]> {
        
        let urlString = "https://jsonplaceholder.typicode.com/todos"
        
        return Promise { seal in
            guard let url = URL(string: urlString) else {
               seal.reject(UserError.invalidURL)
               return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
              guard let data = data, let result = try? JSONDecoder().decode([TodoItem].self, from: data) else {
                seal.reject(error ?? UserError.invalidData)
                self.isLoading = false
                return
              }
              self.todos = result
              self.isLoading = false
              seal.fulfill(result)
                
            }.resume()
        }
    }
    
}


enum UserError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case custom(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
            
        case .invalidResponse:
            return "Invalid Response"
            
        case .invalidData:
            return "Invalid data"
            
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
