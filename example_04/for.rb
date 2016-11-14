puts "Введите число"
number = gets.chomp.to_i

arr = Array.new(number) { |i| i+1 }
puts "#{arr}"

sum = 0
for i in 1..number do
  sum += i
  puts "#{sum}"
end
puts "Сумма от 1 до введенного числа = #{sum}"
