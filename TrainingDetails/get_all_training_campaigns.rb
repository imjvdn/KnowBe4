# Script: get_all_training_campaigns.rb
# Developer: Jadan Morrow
# Description:
# This script fetches all training campaigns from the KnowBe4 API and saves the data to a CSV file.
#
# Use Case:
# This script is useful for obtaining a complete list of all training campaigns, which can help in analyzing training effectiveness, planning future training, and ensuring compliance with training requirements.
#
# API Endpoint: /v1/training/campaigns
# Command to run: ruby get_all_training_campaigns.rb

require 'net/http'
require 'json'
require 'csv'

API_TOKEN = 'eyJhbGciOiJIUzUxMiJ9.eyJzaXRlIjoidHJhaW5pbmcua25vd2JlNC5jb20iLCJ1dWlkIjoiZDExYjQ1NWYtMDliMi00ZDA3LTgyODAtMDY4YjY5ZmM4MThkIiwic2NvcGVzIjpbImVsdmlzIl0sImFpZCI6NDgwOTN9.6J51ajPgsncY2ruXBjI--JzM-Z7P8VlS3bkCtNFboJsZMjbTvk1sta_FptHGJ5OrXzL17sVY95xT5wji26Jy0w'
BASE_URL = 'https://us.api.knowbe4.com/v1/training/campaigns'
OUTPUT_PATH = File.expand_path('~/Downloads/training_campaigns.csv')

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

def fetch_all_training_campaigns(base_url, token)
  fetch_data(base_url, token)
end

def save_to_csv(data, output_path)
  CSV.open(output_path, 'w') do |csv|
    csv << data.first.keys  # Add headers
    data.each { |row| csv << row.values }
  end
end

def main
  data = fetch_all_training_campaigns(BASE_URL, API_TOKEN)
  save_to_csv(data, OUTPUT_PATH)
  puts "All training campaigns data saved to #{OUTPUT_PATH}"
end

main