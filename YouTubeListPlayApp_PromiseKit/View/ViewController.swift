//
//  ViewController.swift
//  YouTubeListPlayApp_PromiseKit
//
//  Created by Ajit Satarkar on 26/12/23.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {
    
    private var viewModel: TodoViewModelProtocol!
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ajit_Satarkar PromiseKit"
        viewModel = TodoViewModel()

        // Set up UITableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
        view.addSubview(tableView)

        // Example usage:
        viewModel.fetchData().done { todos in
            // Handle the todos data
            print("\n fetchData) = \(todos)")
            self.updateUI()
        }.catch { error in
            // Handle the error
            print("Error fetching data: \(error)")
        }
    }

    func updateUI() {
        // Reload UITableView to reflect the updated data
        tableView.reloadData()
    }

}

//MARK: -

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)

        let todo = viewModel.todos[indexPath.row]
        cell.textLabel?.text = todo.title

        return cell
    }
    
}

//https://youtube.com/playlist?list=PLV7VzbWXa60E0rEzFEPsaX38kMXYTY2-R&si=gUnuDeqMXo5Ed5sG

