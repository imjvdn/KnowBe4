# Script: get_all_users.py
# Developer: Jadan Morrow
# Description:
# This script fetches all users from the KnowBe4 API and saves the data to a CSV file.
#
# Use Case:
# This script is useful for getting a comprehensive list of all users in your KnowBe4 account.
# This data can be used for auditing, reporting, and managing user information effectively.
#
# API Endpoint: /v1/users
# Command to run: python get_all_users.py

import requests
import csv
import os

# Constants
API_TOKEN = 'YOUR_API_TOKEN'
BASE_URL = 'https://us.api.knowbe4.com/v1/users'
OUTPUT_PATH = os.path.expanduser('~/Downloads/all_users.csv')


def fetch_data(url, token):
    headers = {
        'Authorization': f'Bearer {token}'
    }
    response = requests.get(url, headers=headers)

    if response.status_code != 200:
        raise Exception(f"Failed to fetch data: {response.text}")

    return response.json()


def fetch_all_users(base_url, token):
    users = []
    page = 1

    while True:
        url = f"{base_url}?page={page}"
        data = fetch_data(url, token)
        if not data:
            break
        users.extend(data)
        page += 1

    return users


def save_to_csv(data, output_path):
    if not data:
        print("No data to save")
        return

    with open(output_path, mode='w', newline='') as file:
        writer = csv.writer(file)

        # Write headers
        writer.writerow(data[0].keys())

        # Write data rows
        for row in data:
            writer.writerow(row.values())

    print(f"All users data saved to {output_path}")


def main():
    data = fetch_all_users(BASE_URL, API_TOKEN)
    save_to_csv(data, OUTPUT_PATH)


if __name__ == '__main__':
    main()
