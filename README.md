# World Countries Explorer App

This Flutter app displays all the countries in the world, with options to filter by continent and search by country name. Users can view detailed information about each country, including native name, population, region, subregion, capital, currencies, languages, and border countries.

## Features

- **Filter by Continent**: Select a continent from the dropdown menu to view only countries from that continent.
- **Search by Country Name**: Quickly find a country by typing its name in the search field.
- **Detailed Country Information**: Click on a country to navigate to a detailed view that includes:
  - Native name
  - Population
  - Region
  - Subregion
  - Capital
  - Currencies
  - Languages
  - Border countries

## Technologies Used

- **Flutter**: UI toolkit for building cross-platform applications.
- **Dart**: Programming language used with Flutter.
- **Cubit (Bloc)**: For state management, providing a simple way to manage and react to changes in the app's state.
- **http**: For making network requests to fetch country data from the [REST Countries API](https://restcountries.com/).

- **SharedPreferences**: For storing local data persistently on the user's device.
- **Animation**: Used to create smooth and interactive user experiences.
- **Responsive Design**: Ensures the app layout works well across various screen sizes and devices.

## API

The app fetches country data from the [REST Countries API](https://restcountries.com/), which provides detailed information on countries.
