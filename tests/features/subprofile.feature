@api @subprofile
Feature: Subprofiles

  Scenario: Sub-profile name should be listed and installed profile
    Given I am logged in as a user with the administrator role
    When I visit "/admin/reports/status"
    Then I should see "Lightning Extender"

  Scenario: Base profile extensions that are excluded by the sub-profile should not be enabled
    Given I am logged in as a user with the administrator role
    When I visit "/admin/modules"
    Then the "edit-modules-lightning-search-enable" checkbox should not be checked

  Scenario: Sub-profile modules should be enabled
    Given I am logged in as a user with the administrator role
    When I visit "/admin/reports/updates"
    Then I should see "Paragraphs"
