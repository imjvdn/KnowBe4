import requests
import csv
import os

# Constants
API_TOKEN = 'eyJhbGciOiJIUzUxMiJ9.eyJzaXRlIjoidHJhaW5pbmcua25vd2JlNC5jb20iLCJ1dWlkIjoiZDExYjQ1NWYtMDliMi00ZDA3LTgyODAtMDY4YjY5ZmM4MThkIiwic2NvcGVzIjpbImVsdmlzIl0sImFpZCI6NDgwOTN9.6J51ajPgsncY2ruXBjI--JzM-Z7P8VlS3bkCtNFboJsZMjbTvk1sta_FptHGJ5OrXzL17sVY95xT5wji26Jy0w'
BASE_URL = 'https://us.api.knowbe4.com/v1/training/campaigns'
OUTPUT_PATH = os.path.expanduser('~/Downloads/specific_training_campaign.csv')


def fetch_data(url, token):
    headers = {
        'Authorization': f'Bearer {token}'
    }
    response = requests.get(url, headers=headers)

    if response.status_code != 200:
        raise Exception(f"Failed to fetch data: {response.text}")

    return response.json()


def fetch_training_campaign(base_url, campaign_id, token):
    url = f"{base_url}/{campaign_id}"
    return fetch_data(url, token)


def save_to_csv(data, output_path):
    with open(output_path, mode='w', newline='') as file:
        writer = csv.writer(file)

        # Write headers
        writer.writerow(data.keys())

        # Write data row
        writer.writerow(data.values())

    print(f"Specific training campaign data saved to {output_path}")


def main():
    campaign_id = input("Enter the campaign ID: ")
    data = fetch_training_campaign(BASE_URL, campaign_id, API_TOKEN)
    save_to_csv(data, OUTPUT_PATH)


if __name__ == '__main__':
    main()