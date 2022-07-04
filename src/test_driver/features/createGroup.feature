Feature: Creating a group
    A group should be added to the correct course.

    Scenario: Create a group
    Given that I'm not in a group
    And I tap the button {Create Group}
    And I write my name
    Then I expect the group to be created and added to the list
