# Script: get_all_training_campaigns.py
# Developer: Jadan Morrow
# Description:
# This script fetches all training campaigns from the KnowBe4 API and saves the data to a CSV file.
#
# Use Case:
# This script is useful for obtaining a complete list of all training campaigns, which can help in analyzing training effectiveness, planning future training, and ensuring compliance with training requirements.
#
# API Endpoint: /v1/training/campaigns
# Command to run: python get_all_training_campaigns.py

import requests
import csv
import os

# Constants
API_TOKEN = 'eyJhbGciOiJIUzUxMiJ9.eyJzaXRlIjoidHJhaW5pbmcua25vd2JlNC5jb20iLCJ1dWlkIjoiZDExYjQ1NWYtMDliMi00ZDA3LTgyODAtMDY4YjY5ZmM4MThkIiwic2NvcGVzIjpbImVsdmlzIl0sImFpZCI6NDgwOTN9.6J51ajPgsncY2ruXBjI--JzM-Z7P8VlS3bkCtNFboJsZMjbTvk1sta_FptHGJ5OrXzL17sVY95xT5wji26Jy0w'
BASE_URL = 'https://us.api.knowbe4.com/v1/training/campaigns'
OUTPUT_PATH = os.path.expanduser('~/Downloads/training_campaigns.csv')


def fetch_data(url, token):
    headers = {
        'Authorization': f'Bearer {token}'
    }
    response = requests.get(url, headers=headers)

    if response.status_code != 200:
        raise Exception(f"Failed to fetch data: {response.text}")

    return response.json()


def fetch_all_training_campaigns(base_url, token):
    return fetch_data(base_url, token)


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

    print(f"All training campaigns data saved to {output_path}")


def main():
    data = fetch_all_training_campaigns(BASE_URL, API_TOKEN)
    save_to_csv(data, OUTPUT_PATH)


if __name__ == '__main__':
    main()