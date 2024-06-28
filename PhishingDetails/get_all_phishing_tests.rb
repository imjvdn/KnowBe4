# get_all_phishing_tests.rb
# Developer: Jadan Morrow
#
# This script retrieves a list of all phishing security tests in your KnowBe4 account.
# It leverages the /v1/phishing/security_tests API endpoint.
# Use case: Useful for getting a comprehensive overview of all phishing tests conducted in the account.
# Run the script using: ruby get_all_phishing_tests.rb
# The output will be saved to the downloads folder as phishing_security_tests.csv

require 'net/http'
require 'json'
require 'csv'

API_TOKEN = 'eyJhbGciOiJIUzUxMiJ9.eyJzaXRlIjoidHJhaW5pbmcua25vd2JlNC5jb20iLCJ1dWlkIjoiZDExYjQ1NWYtMDliMi00ZDA3LTgyODAtMDY4YjY5ZmM4MThkIiwic2NvcGVzIjpbImVsdmlzIl0sImFpZCI6NDgwOTN9.6J51ajPgsncY2ruXBjI--JzM-Z7P8VlS3bkCtNFboJsZMjbTvk1sta_FptHGJ5OrXzL17sVY95xT5wji26Jy0w'
API_URL = 'https://us.api.knowbe4.com/v1/phishing/security_tests'
OUTPUT_PATH = File.expand_path('~/Downloads/phishing_security_tests.csv')

def fetch_data
  uri = URI(API_URL)
  request = Net::HTTP::Get.new(uri)
  request['Authorization'] = "Bearer #{API_TOKEN}"

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }

  raise "Failed to fetch data: #{response.body}" unless response.is_a?(Net::HTTPSuccess)

  JSON.parse(response.body)
end

def save_to_csv(data)
  CSV.open(OUTPUT_PATH, 'w') do |csv|
    csv << data.first.keys
    data.each { |row| csv << row.values }
  end
  puts "Data saved to #{OUTPUT_PATH}"
end

def main
  data = fetch_data
  save_to_csv(data)
end

main