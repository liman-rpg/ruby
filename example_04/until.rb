puts "Введите число"
number = gets.chomp.to_i

arr = Array.new(number) { |i| i+1 }
puts "#{arr}"

sum = 0
i = 1

until i > number do
  sum += i
  i += 1
  puts "#{sum}"
end
puts "Сумма от 1 до введенного числа = #{sum}"
