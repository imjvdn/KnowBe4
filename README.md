# KnowBe4

# KnowBe4 API Scripts

# Description

This repository contains a collection of Ruby scripts developed to interact with the KnowBe4 API. These scripts are designed to fetch various types of data from the KnowBe4 platform, including user details, training campaigns, phishing tests, and account information. Each script is tailored for specific API endpoints and includes detailed comments explaining its purpose, usage, and how to run it.

# Scripts Overview

# AccountDetails

	•	get_account_details.rb: Retrieves and displays the account details including subscription level, number of seats, and current risk score.

# PhishingDetails

	•	get_all_phishing_tests.rb: Fetches a list of all phishing security tests conducted in the account.

# TrainingDetails

	•	get_all_training_campaigns.rb: Retrieves all training campaigns.
	•	get_specific_training_campaign.rb: Retrieves a specific training campaign by ID.

# UserDetails

	•	get_all_users.rb: Fetches a list of all users.
	•	get_specific_user.rb: Retrieves details of a specific user by ID.
	•	get_users_in_group.rb: Retrieves users belonging to a specific group by group ID.

# Usage

Each script can be executed from the command line. For example:

ruby get_account_details.rb

The results are saved in CSV format to the Downloads folder. For scripts that require specific user or group IDs, the script will prompt the user for this information.
