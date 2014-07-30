Feature: Home page (123)
  @javascript
  Scenario: Clicking "increment" button starting with 123
    Given there is score recorded that equals 1234
    When I am on the homepage
    And I click "Increment" button
    Then I should see "The score is 1235"

  @javascript
  Scenario: Repeatedly clicking "increment" button starting wth 123
    Given there is score recorded that equals 123
    When I am on the homepage
    And I click "Increment" button
    And I click "Increment" button
    And I click "Increment" button
    Then I should see "The score is 126"
