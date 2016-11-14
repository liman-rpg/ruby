puts "Введите значение кооэфициента :a"
a = gets.chomp.to_i

puts "Введите значение кооэфициента :b"
b = gets.chomp.to_i

puts "Введите значение кооэфициента :c"
c = gets.chomp.to_i

x = 1

a*x**2 + b*x + c = 0

d = (b**2 - 4*a*c)
s = Math.sqrt(d)

x1 = (-b + s)/(2*a)
x2 = (-b - s)/(2*a)
x = -b/(2*a)

puts "D = #{d}"
puts "A = #{a}"
puts "B = #{b}"
puts "C = #{c}"

if d > 0
  puts "Решение"
  puts "Х1 = #{x1}"
  puts "Х2 = #{x2}"
elsif d == 0
  puts "Решение"
  puts "Х1 = X2 и равно #{x}"
else
  puts "Корней нет"
end
