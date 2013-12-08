Feature: Manage charges
	Charges should be managed properly

	Scenario: Administrators should be able to see the edit and delete actions
		As an admin
		When I go to the charges index page
		Then I should see edit
		And I should see destroy
		When I press destroy
		Then the confirmation box should have been displayed

	Scenario: Administrators should be able to edit a charge
		As an admin
		When I go to the charge view page
		Then I should see "*Organization"
		And I should see "*Charge Type"
		And I should see "*Amount"