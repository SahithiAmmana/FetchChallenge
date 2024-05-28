//
//  MenuDetailsViewController.swift
//  FetchChallenge
//
//  Created by Sahithi Ammana on 5/22/24.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var idMeal: String
    var mealTitle: String?
    var mealDetail: MealDetails?
    private var viewModel: MealDetailViewModel
    
    private var mealTitleLabel: UILabel!
    private var instructionsLabel: UILabel!
    private var mealImageView: UIImageView!
    private var ingredientsLabel: UILabel!
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Initializers
    
    init(idMeal: String, viewModel: MealDetailViewModel = MealDetailViewModel()) {
        self.idMeal = idMeal
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setupScrollView()
        self.setupUI()
        self.viewModel.fetchMealDetails(idMeal: self.idMeal)
        self.activityIndicatorView.startAnimating()
    }
    
    // MARK: - UI Setup
    
    private func setupScrollView() {
        // Configure scroll view and content view
        self.scrollView = UIScrollView()
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.scrollView)
        
        self.contentView = UIView()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.contentView)
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
    
    private func setupUI() {
        // Configure meal image view
        self.mealImageView = UIImageView()
        self.mealImageView.translatesAutoresizingMaskIntoConstraints = false
        self.mealImageView.contentMode = .scaleAspectFill
        self.mealImageView.clipsToBounds = true
        self.contentView.addSubview(self.mealImageView)
        
        // Configure ingredients label
        self.ingredientsLabel = UILabel()
        self.ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.ingredientsLabel.numberOfLines = 0
        self.ingredientsLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(self.ingredientsLabel)
        
        // Configure instructions label
        self.instructionsLabel = UILabel()
        self.instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.instructionsLabel.numberOfLines = 0
        self.instructionsLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(self.instructionsLabel)
        
        // Configure activity indicator view
        self.activityIndicatorView = UIActivityIndicatorView(style: .medium)
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicatorView.hidesWhenStopped = true
        self.contentView.addSubview(self.activityIndicatorView)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            self.mealImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.mealImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.mealImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            self.mealImageView.heightAnchor.constraint(equalToConstant: 200),
            
            self.ingredientsLabel.topAnchor.constraint(equalTo: self.mealImageView.bottomAnchor, constant: 20),
            self.ingredientsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.ingredientsLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            
            self.instructionsLabel.topAnchor.constraint(equalTo: self.ingredientsLabel.bottomAnchor, constant: 8),
            self.instructionsLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.instructionsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.instructionsLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.mealImageView.centerXAnchor),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.mealImageView.centerYAnchor)
        ])
    }
    
    private func updateUI() {
        guard let meal = self.mealDetail else { return }
        self.instructionsLabel.text = meal.strInstructions
        if let mealThumb = meal.strMealThumb {
            loadImageFromURL(imageURLString: mealThumb)
        }
        var ingredientsText = "Ingredients \n"
        for ingredient in meal.ingredients {
            ingredientsText += "\(ingredient.measure) \(ingredient.name)\n"
        }
        self.ingredientsLabel.text = ingredientsText
    }
    
    // MARK: - Image Loading
    
    private func loadImageFromURL(imageURLString: String) {
        guard let imageURL = URL(string: imageURLString) else {
            print("Invalid URL")
            return
        }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.mealImageView.image = UIImage(data: imageData)
                }
            } else {
                print("Failed to load image data")
            }
        }
    }
}

// MARK: - MealDetailViewModelDelegate

extension MealDetailViewController: MealDetailViewModelDelegate {
    func didFetchMealDetails(mealDetail: MealDetails?) {
        guard let mealDetail = mealDetail else {
            print("No meal detail available")
            return
        }
        self.mealDetail = mealDetail
        self.updateUI()
        self.activityIndicatorView.stopAnimating()
    }
}
