import requests
import csv
import os

# Constants
API_TOKEN = 'YOUR_API_KEY'
BASE_URL = 'https://us.api.knowbe4.com/v1/groups'
OUTPUT_PATH = os.path.expanduser('~/Downloads/group_members.csv')


def fetch_data(url, token):
    headers = {
        'Authorization': f'Bearer {token}'
    }
    response = requests.get(url, headers=headers)

    if response.status_code != 200:
        raise Exception(f"Failed to fetch data: {response.text}")

    return response.json()


def fetch_group_members(base_url, group_id, token):
    url = f"{base_url}/{group_id}/members"
    return fetch_data(url, token)


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

    print(f"Group members data saved to {output_path}")


def main():
    group_id = input("Enter the group ID: ")
    data = fetch_group_members(BASE_URL, group_id, API_TOKEN)
    save_to_csv(data, OUTPUT_PATH)


if __name__ == '__main__':
    main()