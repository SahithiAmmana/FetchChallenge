//
//  MealsListViewController.swift
//  FetchChallenge
//
//  Created by Sahithi Ammana on 5/22/24.
//

import UIKit

class MealsListViewController: UIViewController {
    
    // MARK: - Properties
    var mealsTableView: UITableView!
    var viewModel = MealListViewModel()
    var refreshControl = UIRefreshControl()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Desserts"
        self.view.backgroundColor = .white
        
        self.mealsTableView = UITableView()
        self.mealsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.mealsTableView.dataSource = self
        self.mealsTableView.delegate = self
        self.view.addSubview(self.mealsTableView)
        
        NSLayoutConstraint.activate([
            self.mealsTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.mealsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.mealsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mealsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        // Add pull-to-refresh control
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.mealsTableView.refreshControl = refreshControl
               
        self.viewModel.delegate = self
        self.viewModel.fetchMealList()
    }
    
    @objc func refresh() {
        self.viewModel.fetchMealList()
    }
}

// MARK: - UITableView delegate and data source methods
extension MealsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = self.viewModel.meal(at: indexPath.row).strMeal
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let meal = self.viewModel.meal(at: indexPath.row)
        let mealDetailsVC = MealDetailViewController(idMeal: meal.id)
        mealDetailsVC.title = meal.strMeal
        self.navigationController?.pushViewController(mealDetailsVC, animated: true)
    }
}

// MARK: - MealListViewModelDelegate

extension MealsListViewController: MealListViewModelDelegate {
    func didFetchMealList(meals: [Meal]) {
        DispatchQueue.main.async {
            self.mealsTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func didFailWithError(error: Error) {
        print("Failed to fetch meal list: \(error.localizedDescription)")
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Failed to fetch meals. Please check your network connection and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
                // Retry fetching meals
                self.viewModel.fetchMealList()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                self.refreshControl.endRefreshing()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
