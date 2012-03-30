 module TheSmallestDifference
 #! /usr/bin/ruby

 # Get The Weather Data

class Weather
  def self.smallest_temperature_spread
   #open the file to get the data
    begin
      weather_data = File.open 'w_data.dat', 'r'
    rescue =>e
      puts e
    end
      #find the first occurance of column Dy
      first = weather_data.gets.split[0] until first == 'Dy'
      min_diff = 1000
    while not weather_data.eof?
     #split values from file
      table_values = weather_data.gets.split
      next if table_values.length == 0
      #get day of the month values
      dy = table_values[0].to_i

      break if dy == 0
      #subtract column 2 values from column one values to get the difference
      temp_diff = (table_values[1].to_i - table_values[2].to_i)
      #here is the meat of the program
      if temp_diff < min_diff
        min_diff = temp_diff
        min_day = dy
     end
   end
    puts "output:smallest_temperature_spread:The weather is nice the difference is #{min_diff} degrees, on day #{min_day}"

 end
 end

 #The first second program is almost exactly the same logic as the first below I will DRY it up for you
 #Get Soccer Data
class Soccer
  def self.smallest_soccer_spread
    begin
      soccer_data = File.open 'soccer.dat', 'r'
    rescue => e
      puts e
    end
    first = soccer_data.gets.split[0] until first == 'Team'
    minimum_spread = 1000
    while not soccer_data.eof?
     table_values = soccer_data.gets.split
     # data format is more consistent than weather one, so we can do this;
     # just be aware that in other applications, # of line parts may stay same.
     next if table_values.length != 10
       spread = (table_values[6].to_i - table_values[8].to_i)
     #the meat of the soccer logic
     if spread < minimum_spread
       minimum_spread = spread
       #my attempt at humor
       lowest_team = table_values[1]
     end
   end
   puts "output:smallest_soccer_spread:Min spread is #{minimum_spread}, for #{lowest_team}"
 end
 end

class DRY
 #accepts a filename, header name, column name , first and second column names
  def self.dry_method filename, heading_1, column_name, column_1, column_2
    begin
     file = File.open filename, 'r'
    rescue => e
    puts e
    end
    first = file.gets.split[0] until first == heading_1
    minimum_spread = 1000
    while not file.eof?
     table_values = file.gets.split
     next if table_values[0].to_i == 0
     spread = (table_values[column_1].to_i - table_values[column_2].to_i)
     if spread < minimum_spread
       minimum_spread = spread
       minimum_item = table_values[column_name]
     end
   end
   # Could also have passed in a descriptor here, like 'day' or 'team'....
   puts "Min spread is #{minimum_spread}, for #{minimum_item}"
 end
 end
 #call the two different objects before dry

 

 end


 #testing scripts
 require 'test/unit'

 class GerberdataIndyMacTest < Test::Unit::TestCase

   def test_weather_case
     assert_equal TheSmallestDifference::DRY.dry_method('w_data.dat', 'Dy', 0, 1, 2), TheSmallestDifference::Weather.smallest_temperature_spread,
                  'Oh boy something didn\'t work quite right for the weather case'
   end

   def test_soccer_case
     assert_equal TheSmallestDifference::DRY.dry_method('soccer.dat', 'Team', 1, 6, 8), TheSmallestDifference::Soccer.smallest_soccer_spread,
                  'oh boy something didn\'t work quite right for the soccer case'

   end

 end