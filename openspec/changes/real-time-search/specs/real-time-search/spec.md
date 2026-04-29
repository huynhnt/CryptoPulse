## ADDED Requirements

### Requirement: Search Input Field
The system SHALL provide a text input field for users to enter search queries on the All Coins screen.

#### Scenario: Displaying the search field
- **WHEN** the user navigates to the All Coins screen
- **THEN** a search input field is visible at the top of the screen or in the App Bar

### Requirement: Search Debounce Mechanism
The system SHALL delay the API request for search results until 300ms have passed since the user's last keystroke.

#### Scenario: User types multiple characters quickly
- **WHEN** the user types "bit" with less than 300ms between each keystroke
- **THEN** the system only makes one API request for the complete query "bit" after 300ms of inactivity

### Requirement: Real-time Search Results Display
The system SHALL display the search results fetched from the `/coins/search` API using the existing `CoinListItem` UI component.

#### Scenario: Displaying matching results
- **WHEN** the API returns a list of matching coins
- **THEN** the system displays the coins in a list format, each rendered as a `CoinListItem`

#### Scenario: Handling empty search query
- **WHEN** the search input is cleared (becomes empty)
- **THEN** the system hides the search results and displays the default All Coins list

### Requirement: Search Loading State
The system SHALL display a loading indicator while fetching search results from the API.

#### Scenario: Waiting for API response
- **WHEN** a search API request is initiated after the 300ms debounce
- **THEN** the system displays a `CircularProgressIndicator` until the response is received

### Requirement: Empty Search Results
The system SHALL display a friendly message when no coins match the search query.

#### Scenario: No matches found
- **WHEN** the API returns an empty list for a search query
- **THEN** the system displays a message indicating "No coins found"
