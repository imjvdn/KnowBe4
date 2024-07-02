# Script: get_specific_user.py
# Developer: Jadan Morrow
# Description:
# This script fetches a specific user's data from the KnowBe4 API using the user_id and saves the data to a CSV file.
#
# Use Case:
# This script is useful for retrieving detailed information about a specific user, which can help in monitoring, auditing, and managing user-specific actions or roles within the organization.
#
# API Endpoint: /v1/users/{user_id}
# Command to run: python get_specific_user.py

import requests
import csv
import os

# Constants
API_TOKEN = 'YOUR_API_TOKEN'
BASE_URL = 'https://us.api.knowbe4.com/v1/users'
OUTPUT_PATH = os.path.expanduser('~/Downloads/specific_user.csv')


def fetch_data(url, token):
    headers = {
        'Authorization': f'Bearer {token}'
    }
    response = requests.get(url, headers=headers)

    if response.status_code != 200:
        raise Exception(f"Failed to fetch data: {response.text}")

    return response.json()


def fetch_user(base_url, user_id, token):
    url = f"{base_url}/{user_id}"
    return fetch_data(url, token)


def save_to_csv(data, output_path):
    with open(output_path, mode='w', newline='') as file:
        writer = csv.writer(file)

        # Write headers
        writer.writerow(data.keys())

        # Write data row
        writer.writerow(data.values())

    print(f"Specific user data saved to {output_path}")


def main():
    user_id = input("Please enter the user ID: ")
    data = fetch_user(BASE_URL, user_id, API_TOKEN)
    save_to_csv(data, OUTPUT_PATH)


if __name__ == '__main__':
    main()
