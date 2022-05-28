# Your Code Starts Here
require 'csv'
puts "Which CSV? 1, 2, or 3?"
chosenCSV = "input" + gets.chomp + ".csv"

# puts "Email, Phone, or Both?"
# searchTerm = gets.chomp.downcase


data = CSV.parse(File.read(chosenCSV), headers: true, header_converters: :symbol).map(&:to_h)
puts data

puts "----------------------"


output = (data[1].keys & data[6].keys).select { |k| data[1][k] == data[6][k] }
#puts output
