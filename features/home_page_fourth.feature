Feature: Home page (10000)
  @javascript
  Scenario: Clicking "increment" button starting with 10000
    Given there is score recorded that equals 10000
    When I am on the homepage
    And I click "Increment" button
    Then I should see "The score is 10001"

  @javascript
  Scenario: Repeatedly clicking "increment" button starting with 10000
    Given there is score recorded that equals 10000
    When I am on the homepage
    And I click "Increment" button
    And I click "Increment" button
    And I click "Increment" button
    Then I should see "The score is 10003"
