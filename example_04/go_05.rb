puts "Введите число"
number = gets.chomp.to_i

arr = Array.new(number) { |i| i+1 }
puts "#{arr}"

sum = 0

(1..number).each do |i|
  sum += i*i
  puts "#{sum}"
end
puts "Сумма от 1 до введенного числа = #{sum}"
