puts "Введите день месяца"
a = gets.chomp.to_i

puts "Введите номер меcяца"
n = gets.chomp.to_i

puts "Введите год"
c = gets.chomp.to_i

year = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

d = 0
i = 1

while i < n
  if c%4 == 0
    year[2] = 29
    d += year[i] + n
    i += 1
  elsif c%4 != 0
    d += year[i] + n
    i += 1
  end
end

puts "#{d} день в году"

puts "Число дней в феврале = #{year[2]}"
