puts "Введите число"
number = gets.strip.to_i

if number%2 == 0
  puts "Число четное"
elsif number%2 != 0
  puts "Число нечетное"
else
  puts "Не правильный запрос"
end
