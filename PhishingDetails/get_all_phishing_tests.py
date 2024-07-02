# get_all_phishing_tests.py
# Developer: Jadan Morrow
#
# This script retrieves a list of all phishing security tests in your KnowBe4 account.
# It leverages the /v1/phishing/security_tests API endpoint.
# Use case: Useful for getting a comprehensive overview of all phishing tests conducted in the account.
# Run the script using: python get_all_phishing_tests.py
# The output will be saved to the downloads folder as phishing_security_tests.csv

import requests
import csv
import os

# Constants
API_TOKEN = 'YOUR_API_TOKEN'
API_URL = 'https://us.api.knowbe4.com/v1/phishing/security_tests'
OUTPUT_PATH = os.path.expanduser('~/Downloads/phishing_security_tests.csv')


def fetch_data(url, token):
    headers = {
        'Authorization': f'Bearer {token}'
    }
    response = requests.get(url, headers=headers)

    if response.status_code != 200:
        raise Exception(f"Failed to fetch data: {response.text}")

    return response.json()


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

    print(f"Data saved to {output_path}")


def main():
    data = fetch_data(API_URL, API_TOKEN)
    save_to_csv(data, OUTPUT_PATH)


if __name__ == '__main__':
    main()
