## ADDED Requirements

### Requirement: App fetches coin list from backend
The mobile application SHALL fetch the list of top coins from the internal backend service instead of the external CoinGecko API.

#### Scenario: User opens the dashboard
- **WHEN** the dashboard screen initializes and requests coin data
- **THEN** the app makes a GET request to `http://localhost:8088/coins` (or the equivalent local IP)
- **AND** successfully displays the list of coins including their sparkline charts.

### Requirement: App handles robust sparkline parsing
The application SHALL be able to parse sparkline data whether it is wrapped in an object (`{"price": [...]}`) or provided as a direct array (`[...]`).

#### Scenario: Parsing backend coin response
- **WHEN** the backend returns a coin with `"sparkline_in_7d": [10.5, 11.2, 10.8]`
- **THEN** the app successfully parses this array into a `List<double>` for rendering the chart.

### Requirement: App fetches market chart from backend
The application SHALL fetch detailed market chart data from the internal backend service for the Coin Detail screen.

#### Scenario: User views coin details
- **WHEN** the user taps on a coin to view its details
- **THEN** the app makes a GET request to `http://localhost:8088/coins/<id>/chart?days=<days>`
- **AND** displays the detailed historical chart.
