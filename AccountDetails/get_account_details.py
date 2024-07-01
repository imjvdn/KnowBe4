# Script: get_account_details.py
# Developer: Jadan Morrow
# Description:
# This script fetches account details from the KnowBe4 API and saves the data to a CSV file.
#
# Use Case:
# This script is useful for retrieving comprehensive details about your KnowBe4 account.
# This data can be used for auditing, reporting, and managing account-level information effectively.
#
# API Endpoint: /v1/account?full=true
# Command to run: python get_account_details.py

import requests
import csv
import os

# Constants
API_TOKEN = 'eyJhbGciOiJIUzUxMiJ9.eyJzaXRlIjoidHJhaW5pbmcua25vd2JlNC5jb20iLCJ1dWlkIjoiZDExYjQ1NWYtMDliMi00ZDA3LTgyODAtMDY4YjY5ZmM4MThkIiwic2NvcGVzIjpbImVsdmlzIl0sImFpZCI6NDgwOTN9.6J51ajPgsncY2ruXBjI--JzM-Z7P8VlS3bkCtNFboJsZMjbTvk1sta_FptHGJ5OrXzL17sVY95xT5wji26Jy0w'
BASE_URL = 'https://us.api.knowbe4.com/v1/account?full=true'
OUTPUT_PATH = os.path.expanduser('~/Downloads/account_details.csv')


def fetch_data(url, token):
    headers = {
        'Authorization': f'Bearer {token}'
    }
    response = requests.get(url, headers=headers)

    if response.status_code != 200:
        raise Exception(f"Failed to fetch data: {response.text}")

    return response.json()


def save_to_csv(data, output_path):
    with open(output_path, mode='w', newline='') as file:
        writer = csv.writer(file)

        # Write headers
        writer.writerow(['Account Name', 'Type', 'Subscription Level', 'Subscription End Date', 'Number of Seats',
                         'Current Risk Score', 'Domain', 'Admin Name', 'Admin Email'])

        # Write account details (excluding admins)
        common_data = [
            data['name'],
            data['type'],
            data['subscription_level'],
            data['subscription_end_date'],
            data['number_of_seats'],
            data['current_risk_score'],
            ", ".join(data['domains'])
        ]

        # Write each admin on a new row
        for admin in data['admins']:
            admin_name = admin.get('name', 'N/A')
            admin_email = admin.get('email', 'N/A')
            writer.writerow(common_data + [admin_name, admin_email])


def main():
    data = fetch_data(BASE_URL, API_TOKEN)
    save_to_csv(data, OUTPUT_PATH)
    print(f"Account details saved to {OUTPUT_PATH}")


if __name__ == '__main__':
    main()