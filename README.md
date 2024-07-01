# KnowBe4

KnowBe4 API Scripts

## Description

This repository contains a collection of Python scripts developed to interact with the KnowBe4 API. These scripts are designed to fetch various types of data from the KnowBe4 platform, including user details, training campaigns, phishing tests, and account information. Each script is tailored for specific API endpoints and includes detailed comments explaining its purpose, usage, and how to run it.

## Scripts Overview

### AccountDetails

- `get_account_details.py`: Retrieves and displays the account details including subscription level, number of seats, and current risk score.

### PhishingDetails

- `get_all_phishing_tests.py`: Fetches a list of all phishing security tests conducted in the account.

### TrainingDetails

- `get_all_training_campaigns.py`: Retrieves all training campaigns.
- `get_specific_training_campaign.py`: Retrieves a specific training campaign by ID.

### UserDetails

- `get_all_users.py`: Fetches a list of all users.
- `get_specific_user.py`: Retrieves details of a specific user by ID.
- `get_users_in_group.py`: Retrieves users belonging to a specific group by group ID.

## Usage

The results are saved in CSV format to the Downloads folder. For scripts that require specific user or group IDs, the script will prompt the user for this information.

Additionally, the same functionality is available in the Ruby scripts found in this repository.

Each script can be executed from the command line. For example:

```bash
python get_account_details.py
