# Script: get_all_users.rb
# Developer: Jadan Morrow
# Description:
# This script fetches all users from the KnowBe4 API and saves the data to a CSV file.
#
# Use Case:
# This script is useful for getting a comprehensive list of all users in your KnowBe4 account.
# This data can be used for auditing, reporting, and managing user information effectively.
#
# API Endpoint: /v1/users
# Command to run: ruby get_all_users.rb

require 'net/http'
require 'json'
require 'csv'

API_TOKEN = 'YOUR_API_KEY'
BASE_URL = 'https://us.api.knowbe4.com/v1/users'
OUTPUT_PATH = File.expand_path('~/Downloads/all_users.csv')

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

def fetch_all_users(base_url, token)
  users = []
  page = 1

  loop do
    url = "#{base_url}?page=#{page}"
    data = fetch_data(url, token)
    break if data.empty?

    users.concat(data)
    page += 1
  end

  users
end

def save_to_csv(data, output_path)
  CSV.open(output_path, 'w') do |csv|
    csv << data.first.keys  # Add headers
    data.each { |row| csv << row.values }
  end
end

def main
  data = fetch_all_users(BASE_URL, API_TOKEN)
  save_to_csv(data, OUTPUT_PATH)
  puts "All users data saved to #{OUTPUT_PATH}"
end

main
