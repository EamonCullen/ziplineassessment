# Your Code Starts Here
require 'csv'

#ARGV.capitalize

ARGV.each do|a|
  puts "You selected: #{a}"
end

# Parse CSV file to array of hashes with CSV headers as the keys
data = CSV.parse(File.read(ARGV[0]), headers: true).map(&:to_h)


def matchingType(elements, keyword)
  nilElements = elements.select {|e| e[keyword].nil?}
  # Get rid of key:values with nil values to avoid comparing
  noNilElements = elements.reject {|e| e[keyword].nil?}
  id = 0
  result = []

#Compares each row with subsequent rows for matches and appends id values as key:value pairs
  noNilElements.each do |currentElement|

    match = result.find {|previousElement| currentElement[keyword] == previousElement[keyword]}

    if match
      currentElement["ID"] = match["ID"]
    else
      currentElement["ID"] = id
      id += 1
    end

    result << currentElement
  end

# hashes with nil values for search term assigned id
  nilElements.each do |currentElement|
    currentElement["ID"] = elements.length + id
    id += 1
  end

#Append elements which had nil values for search term back on to end of array
  result << nilElements
end


#Function to output array back to CSV
 class Array
 def to_csv(csv_filename = "csv_output_with_id.csv")
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

 class String
 def exclude?(string)
   !include?(string)
 end
end

#email checked first
 if (ARGV[1].exclude? "Email") && (ARGV[2].include? "Email")
   ARGV[1], ARGV[2] = ARGV[2], ARGV[1]
 end

#Call matchingType on any arguments called
searchedArray= []

ARGV.each do |argument|
  searchedArray = matchingType(data, argument)
end

 begin
   searchedArray.to_csv()
 rescue TypeError
   puts "Done!"
 end
