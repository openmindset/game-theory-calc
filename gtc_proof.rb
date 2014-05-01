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
puts "Enter total number of customers:"

customers_total = gets.chomp.to_i

puts "Enter number of loyal customers:"

customers_loyal = gets.chomp.to_i

puts "Enter number of swing customers:"

customers_swing = gets.chomp.to_i

price_array = [price_high, price_medium, price_low] 
price_arrayA = [price_high, price_medium, price_low]
price_arrayB = [price_high, price_medium, price_low]

pricemix_array = price_arrayA.product(price_arrayB)


baseprice_array = Array.new

price_array.each do |price|
	baseprice_array << price * customers_loyal
end	

finalprice_array = Array.new


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
		finalprice_array << total_priceA
		finalprice_array << total_priceB
	elsif sub_array[0] < sub_array[1]
		swing_priceA = customers_swing * sub_array[0]
		loyal_priceA = customers_loyal * sub_array[0] 
		total_priceA = swing_priceA + loyal_priceA
		total_priceB = customers_loyal * sub_array[1]
		finalprice_array << total_priceA
		finalprice_array << total_priceB

	elsif sub_array[0] > sub_array[1]
		swing_priceB = customers_swing * sub_array[1]
		loyal_priceB = customers_loyal * sub_array[1]
		total_priceB = swing_priceB + loyal_priceB
		total_priceA = customers_loyal * sub_array[0]
		finalprice_array << total_priceA
		finalprice_array << total_priceB
	end
end

puts finalprice_array.to_s




