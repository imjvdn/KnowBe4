# Script: get_account_details.rb
# Developer: Jadan Morrow
# Description:
# This script fetches account details from the KnowBe4 API and saves the data to a CSV file.
#
# Use Case:
# This script is useful for retrieving comprehensive details about your KnowBe4 account.
# This data can be used for auditing, reporting, and managing account-level information effectively.
#
# API Endpoint: /v1/account?full=true
# Command to run: ruby get_account_details.rb

require 'net/http'
require 'json'
require 'csv'

API_TOKEN = 'eyJhbGciOiJIUzUxMiJ9.eyJzaXRlIjoidHJhaW5pbmcua25vd2JlNC5jb20iLCJ1dWlkIjoiZDExYjQ1NWYtMDliMi00ZDA3LTgyODAtMDY4YjY5ZmM4MThkIiwic2NvcGVzIjpbImVsdmlzIl0sImFpZCI6NDgwOTN9.6J51ajPgsncY2ruXBjI--JzM-Z7P8VlS3bkCtNFboJsZMjbTvk1sta_FptHGJ5OrXzL17sVY95xT5wji26Jy0w'
BASE_URL = 'https://us.api.knowbe4.com/v1/account?full=true'
OUTPUT_PATH = File.expand_path('~/Downloads/account_details.csv')

def fetch_data(url, token)
  uri = URI(url)
  request = Net::HTTP::Get.new(uri)
  request['Authorization'] = "Bearer #{token}"

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(request)
  end

  raise "Failed to fetch data: #{response.body}" unless response.is_a?(Net::HTTPSuccess)

  JSON.parse(response.body)
end

def fetch_account_details(base_url, token)
  fetch_data(base_url, token)
end

def save_to_csv(data, output_path)
  CSV.open(output_path, 'w') do |csv|
    # Write headers
    csv << ['Account Name', 'Type', 'Subscription Level', 'Subscription End Date', 'Number of Seats', 'Current Risk Score', 'Domain', 'Admin Name', 'Admin Email']

    # Write account details (excluding admins)
    common_data = [
      data['name'],
      data['type'],
      data['subscription_level'],
      data['subscription_end_date'],
      data['number_of_seats'],
      data['current_risk_score'],
      data['domains'].join(", ")
    ]

    # Write each admin on a new row
    data['admins'].each do |admin|
      csv << common_data + [admin['name'], admin['email']]
    end
  end
end

def main
  data = fetch_account_details(BASE_URL, API_TOKEN)
  save_to_csv(data, OUTPUT_PATH)
  puts "Account details saved to #{OUTPUT_PATH}"
end

main