Feature: Home page other feature (0)
  @javascript
  Scenario: Clicking "increment" button starting with 0
    Given there is score recorded that equals 0
    When I am on the homepage
    And I click "Increment" button
    Then I should see "The score is 1"

  @javascript
  Scenario: Repeatedly clicking "increment" button starting with 0
    Given there is score recorded that equals 0
    When I am on the homepage
    And I click "Increment" button
    And I click "Increment" button
    And I click "Increment" button
    Then I should see "The score is 3"
