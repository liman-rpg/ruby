puts "Введите значение стороны :a"
a = gets.chomp.to_i

puts "Введите значение стороны :b"
b = gets.chomp.to_i

puts "Что Вы хотите вычислить периметр или площадь?"
request = gets.strip

perimetr = 2*a + 2*b
area = a*b

if request == 'периметр'
  puts "Периметр равен = #{perimetr}"
elsif request == 'площадь'
  puts "Площадь равна = #{area}"
else
  puts "Не правильный запрос"
end
