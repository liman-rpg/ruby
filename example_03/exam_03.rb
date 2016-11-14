puts "Введите значение стороны :a"
a = gets.chomp.to_i

puts "Введите значение стороны :b"
b = gets.chomp.to_i

puts "Введите значение стороны :c"
c = gets.chomp.to_i

arr = [a, b, c].sort

if a==b && b==c
  puts 'Треугольник равносторонний'
elsif arr[-1]**2 == arr[-2]**2 + arr[-3]**2
  puts 'Треугольник прямоугольный'
elsif a==b || b==c
  puts 'Треугольник равнобедренный'
elsif a!=b && b!=c && a!=c
  puts 'Треугольник разносторонний'
end
