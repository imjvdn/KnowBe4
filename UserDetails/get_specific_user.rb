# Script: get_specific_user.rb
# Developer: Jadan Morrow
# Description:
# This script fetches a specific user's data from the KnowBe4 API using the user_id and saves the data to a CSV file.
#
# Use Case:
# This script is useful for retrieving detailed information about a specific user, which can help in monitoring, auditing, and managing user-specific actions or roles within the organization.
#
# API Endpoint: /v1/users/{user_id}
# Command to run: ruby get_specific_user.rb

require 'net/http'
require 'json'
require 'csv'

API_TOKEN = 'YOUR_API_KEY'
BASE_URL = 'https://us.api.knowbe4.com/v1/users'
OUTPUT_PATH = File.expand_path('~/Downloads/specific_user.csv')

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

def fetch_user(base_url, user_id, token)
  url = "#{base_url}/#{user_id}"
  fetch_data(url, token)
end

def save_to_csv(data, output_path)
  CSV.open(output_path, 'w') do |csv|
    csv << data.keys  # Add headers
    csv << data.values
  end
end

def main
  puts "Please enter the user ID:"
  user_id = gets.chomp
  data = fetch_user(BASE_URL, user_id, API_TOKEN)
  save_to_csv(data, OUTPUT_PATH)
  puts "Specific user data saved to #{OUTPUT_PATH}"
end

main
