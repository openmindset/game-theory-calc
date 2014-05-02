require 'gchart'


puts "Welcome to the Game Theory calculator."
puts "Please enter the name of Player A:"

player_A = gets.chomp

puts "Please enter the name of Player B:"

player_B = gets.chomp

puts "Now we need to set our price points (actions)."
puts "Please enter the high price:"

price_high = gets.chomp.to_i

puts "Please enter the middle price:"

price_medium = gets.chomp.to_i

puts "Please enter the low price:"

price_low = gets.chomp.to_i

puts "Ok, now for the rules."

puts "Enter number of loyal customers:"

customers_loyal = gets.chomp.to_i

puts "Enter number of swing customers:"

customers_swing = gets.chomp.to_i


# these are temp variables for quicker testing
=begin
player_A = "playA"
player_B = "playB"
price_high = 12
price_medium = 10
price_low = 5
customers_total = 1000
customers_loyal = 300
customers_swing = 400
=end


price_array = [price_high, price_medium, price_low] 
price_arrayA = [price_high, price_medium, price_low]
price_arrayB = [price_high, price_medium, price_low]

pricemix_array = price_arrayA.product(price_arrayB)

baseprice_array = Array.new

price_array.each do |price|
	baseprice_array << price * customers_loyal
end	

finalprice_arrayA = Array.new
finalprice_arrayB = Array.new

pricemix_array.each do |sub_array|
	if sub_array[0] == sub_array[1]
		#puts sub_array.to_s
		#puts "they match"
		customers_swinghalf = customers_swing / 2
		swing_price = customers_swinghalf * sub_array[0]
		#puts "swingprice = #{swing_price}"
		loyal_price = customers_loyal * sub_array[0]
		#puts "loyalprice = #{loyal_price}"
		total_priceA = swing_price + loyal_price
		total_priceB = swing_price + loyal_price
		#puts "total price = #{total_price}"
		finalprice_arrayA << total_priceA
		finalprice_arrayB << total_priceB
	elsif sub_array[0] < sub_array[1]
		swing_priceA = customers_swing * sub_array[0]
		loyal_priceA = customers_loyal * sub_array[0] 
		total_priceA = swing_priceA + loyal_priceA
		total_priceB = customers_loyal * sub_array[1]
		finalprice_arrayA << total_priceA
		finalprice_arrayB << total_priceB

	elsif sub_array[0] > sub_array[1]
		swing_priceB = customers_swing * sub_array[1]
		loyal_priceB = customers_loyal * sub_array[1]
		total_priceB = swing_priceB + loyal_priceB
		total_priceA = customers_loyal * sub_array[0]
		finalprice_arrayA << total_priceA
		finalprice_arrayB << total_priceB
	end
end

=begin
finalprice_array.each_slice(2) do |a| 
		puts "#{player_A} = #{a[0]}"
		puts "#{player_B} = #{a[1]}"	
end
=end

puts "Writing image file..."

chart_max_value = finalprice_arrayA.max
chart_min_value = finalprice_arrayA.min - 1000

bar_chart = Gchart.new(
            :type => 'bar',
            :size => '600x500',
            :bar_colors => ['AA0000', '0099FF'],
            :title => "Profit Simulation",
            :bg => 'EFEFEF',
            :legend => [player_A, player_B],
            :data => [finalprice_arrayA, finalprice_arrayB],
            :filename => 'images/bar_chart1.png',
            :stacked => false,
            :legend_position => 'bottom',
            :axis_with_labels => [['x'], ['y']],
            :max_value => chart_max_value,
            :min_value => chart_min_value,
            :axis_labels => [pricemix_array],
            :bar_width_and_spacing => '25',            
            )

bar_chart.write
puts "Image saved in #{Dir.pwd}/images"


=begin
begin
  file = File.open("images/bar_chart1.png", "w")
  file.write(bar_chart.file) 
rescue IOError => e
  #some error occur, dir not writable etc.
ensure
  file.close unless file == nil
end
=end
