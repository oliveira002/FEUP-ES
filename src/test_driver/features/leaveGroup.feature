Feature: Leaving a group
    You should be removed from the correct group.

    Scenario: Leave a group
    Given that I'm in a group
    And I tap the button {Leave Group}
    And I type my name
    Then I expect to be removed and the group to be updated