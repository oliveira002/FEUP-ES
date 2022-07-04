Feature: Choosing a Course
    You should be redirected to the correct page regarding the course you choose.

    Scenario: Page changes according to the course  you choose
        Given I'm on the home page
        And I tap a "{course}" button
        Then I expect to be redirected to the correct "{course}" page