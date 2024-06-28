# Script: get_specific_training_campaign.rb
# Developer: Jadan Morrow
# Description:
# This script fetches a specific training campaign from the KnowBe4 API using the campaign_id and saves the data to a CSV file.
#
# Use Case:
# This script is useful for retrieving detailed information about a specific training campaign, which can help in analyzing its effectiveness, managing enrollments, and ensuring compliance with training requirements.
#
# API Endpoint: /v1/training/campaigns/{campaign_id}
# Command to run: ruby get_specific_training_campaign.rb

require 'net/http'
require 'json'
require 'csv'

API_TOKEN = 'eyJhbGciOiJIUzUxMiJ9.eyJzaXRlIjoidHJhaW5pbmcua25vd2JlNC5jb20iLCJ1dWlkIjoiZDExYjQ1NWYtMDliMi00ZDA3LTgyODAtMDY4YjY5ZmM4MThkIiwic2NvcGVzIjpbImVsdmlzIl0sImFpZCI6NDgwOTN9.6J51ajPgsncY2ruXBjI--JzM-Z7P8VlS3bkCtNFboJsZMjbTvk1sta_FptHGJ5OrXzL17sVY95xT5wji26Jy0w'
BASE_URL = 'https://us.api.knowbe4.com/v1/training/campaigns'
OUTPUT_PATH = File.expand_path('~/Downloads/specific_training_campaign.csv')

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

def fetch_training_campaign(base_url, campaign_id, token)
  url = "#{base_url}/#{campaign_id}"
  fetch_data(url, token)
end

def save_to_csv(data, output_path)
  CSV.open(output_path, 'w') do |csv|
    csv << data.keys  # Add headers
    csv << data.values
  end
end

def main
  print "Enter the campaign ID: "
  campaign_id = gets.chomp
  data = fetch_training_campaign(BASE_URL, campaign_id, API_TOKEN)
  save_to_csv(data, OUTPUT_PATH)
  puts "Specific training campaign data saved to #{OUTPUT_PATH}"
end

main