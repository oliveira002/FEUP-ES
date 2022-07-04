Feature: Joining a group
    You should be added to the correct group.

    Scenario: Join a group
    Given that I'm not in a group 
    And I tap the {Join Group} button
    And the group is not full
    Then I expect to be added to the group 
    And the group to be updated