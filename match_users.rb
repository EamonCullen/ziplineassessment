# Your Code Starts Here
require 'csv'
puts "Which CSV? 1, 2, or 3?"
chosenCSV = "input" + gets.chomp + ".csv"

# puts "Email, Phone, or Both?"
# searchTerm = gets.chomp.downcase


data = CSV.parse(File.read(chosenCSV), headers: true).map(&:to_h)
puts data

puts "----------------------"


# output = (data[1].keys & data[6].keys).select { |k| data[1][k] == data[6][k] }

# for i in 0..data.length
#   for j in i..data.length
#     # puts data[j + 1]
#     output = (data[j].keys & data[j+1].keys).select { |k| data[j][k] == data[j+1][k] }
#     puts data[j]
#     puts data[j+1]
#     puts output
#   end
#   puts "*****"
# end

for i in 0..data.length-2
  for j in i+1..data.length-1
    output = (data[i].keys & data[j].keys).select { |k| data[i][k] == data[j][k] }
    puts "We are comparing this row..."
    puts data[i]
    puts "With this row!"
    puts data[j]

    puts "Here's the output:"
    puts output
    puts "*****"

    if output.include? "Email"
      puts "Match!"
      puts "---"
    else
      puts "No match :("
      puts "---"
    end

  end
end
