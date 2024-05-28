# Fetch - iOS Coding Challenge

## Introduction
This project is a native iOS app developed as part of the Fetch coding challenge. The app allows users to browse recipes using the MealDB API. It fetches a list of meals in the Dessert category and displays them alphabetically. Users can select a meal to view its details, including name, instructions, and ingredients/measurements.

## Requirements
- Xcode 13 or later
- Swift 5
- iOS 13.0 or later

## Installation
1. Clone or download the repository.
2. Open the project in Xcode.
3. Build and run the project on a simulator or device.

## Features
- Fetches a list of meals in the Dessert category from the MealDB API.
- Displays the list of meals sorted alphabetically.
- Allows users to pull to refresh the meal list.
- Displays detailed information about each meal, including name, instructions, and ingredients/measurements.
- Handles network errors gracefully and provides a retry option.
- Utilizes UIKit for the user interface.

## Usage
- Upon launching the app, users are presented with a list of desserts.
- Users can pull down on the meal list to refresh the data.
- Tapping on a meal in the list navigates to a detail view with more information about the selected meal.

## Architecture
The app follows the MVVM (Model-View-ViewModel) architecture pattern. This helps in separating concerns, making the codebase more modular, testable, and maintainable.

### Model
The Model represents the data layer of the app. It includes data structures and network service classes responsible for fetching data from the API.

- **Meal**: Represents a meal with basic information.
- **MealDetails**: Represents detailed information about a meal.
- **Network**: Handles API requests to fetch meal data from the MealDB API.

### ViewModel
The ViewModel acts as a bridge between the View and the Model. It manages the data logic and prepares data for display in the View.

- **MealListViewModel**: Manages the fetching and sorting of meal data. Notifies the ViewController via the `MealListViewModelDelegate` protocol.
- **MealDetailViewModel**: Manages the fetching of detailed meal information. Notifies the `MealDetailViewController` via the `MealDetailViewModelDelegate` protocol.

### View
The View layer is responsible for the UI and user interactions. It observes the ViewModel and updates the UI accordingly.

- **MealsListViewController**: Displays a list of meals in a `UITableView`. Handles pull-to-refresh and navigation to meal details.
- **MealDetailViewController**: Displays detailed information about a selected meal. Updates the UI based on data provided by the `MealDetailViewModel`.



*This project was developed by Sahithi Ammana as part of the Fetch coding challenge. For more information, please contact sahithi.ammana@gmail.com.*
