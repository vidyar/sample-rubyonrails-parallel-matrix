Feature: Home page other featue (100)
  @javascript
  Scenario: Clicking "increment" button starting with 100
    Given there is score recorded that equals 100
    When I am on the homepage
    And I click "Increment" button
    Then I should see "The score is 101"

  @javascript
  Scenario: Repeatedly clicking "increment" button starting with 100
    Given there is score recorded that equals 100
    When I am on the homepage
    And I click "Increment" button
    And I click "Increment" button
    And I click "Increment" button
    Then I should see "The score is 103"
