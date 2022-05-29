# Your Code Starts Here
require 'csv'
puts "Which CSV? 1, 2, or 3?"
chosenCSV = "input" + gets.chomp + ".csv"

puts "Email, Phone, or Both?"
searchTerm = gets.chomp.capitalize

data = CSV.parse(File.read(chosenCSV), headers: true).map(&:to_h)

puts "----------------------"

def matchingType(elements, keyword)
  # Get rid of elements with nil values.
  nilElements = elements.select {|e| e[keyword].nil?}
  noNilElements = elements.reject {|e| e[keyword].nil?}
  id = 0
  result = []

  noNilElements.each do |currentElement|

    match = result.find {|previousElement| currentElement[keyword] == previousElement[keyword]}
    emailMatch = result.find {|previousElement| currentElement["Email"] == previousElement["Email"]}
    phoneMatch = result.find {|previousElement| currentElement["Phone"] == previousElement["Phone"]}

    case keyword
    when "Both"
      if emailMatch
        currentElement["ID"] = match["ID"]
      elsif phoneMatch
        currentElement["ID"] = match["ID"]
      else
        currentElement["ID"] = id
        id += 1
      end

    else

      if match
        currentElement["ID"] = match["ID"]
      else
      currentElement["ID"] = id
      id += 1
    end

    result << currentElement
  end

  nilElements.each do |currentElement|
    currentElement["ID"] = elements.length + id
    id += 1
  end

  result << nilElements
end
end

class Array
def to_csv(csv_filename = "hash.csv")
  require "csv"
  CSV.open(csv_filename, "wb") do |csv|
    keys = first.keys
    csv << keys
    self.each do |hash|
      csv << hash.values_at(*keys)
      puts hash
    end
  end
end
end

searchedArray = matchingType(data, searchTerm)

begin
  searchedArray.to_csv()
rescue TypeError
  puts "Done!"
end
