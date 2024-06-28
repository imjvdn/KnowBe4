# Script: get_users_in_group.rb
# Developer: Jadan Morrow
# Description:
# This script fetches all users who are members of a specific group from the KnowBe4 API using the group_id and saves the data to a CSV file.
#
# Use Case:
# This script is useful for obtaining a list of users in a specific group, which can assist in group-based reporting, managing group-specific training, or monitoring group-specific performance and compliance.
#
# API Endpoint: /v1/groups/{group_id}/members
# Command to run: ruby get_users_in_group.rb

require 'net/http'
require 'json'
require 'csv'

API_TOKEN = 'YOUR_API_KEY'
BASE_URL = 'https://us.api.knowbe4.com/v1/groups'
OUTPUT_PATH = File.expand_path('~/Downloads/group_members.csv')

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

def fetch_group_members(base_url, group_id, token)
  url = "#{base_url}/#{group_id}/members"
  fetch_data(url, token)
end

def save_to_csv(data, output_path)
  CSV.open(output_path, 'w') do |csv|
    csv << data.first.keys  # Add headers
    data.each { |row| csv << row.values }
  end
end

def main
  print "Enter the group ID: "
  group_id = gets.chomp
  data = fetch_group_members(BASE_URL, group_id, API_TOKEN)
  save_to_csv(data, OUTPUT_PATH)
  puts "Group members data saved to #{OUTPUT_PATH}"
end

main
