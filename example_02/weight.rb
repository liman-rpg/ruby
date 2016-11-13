puts "Привет, как тебя зовут?"
name = gets.strip.to_s
puts "Привет, #{name}"

puts "Какой у Вас рост?"
growth = gets.strip.to_i

weight = growth - 110

if weight >= 0
  puts "Ваш оптимальный вес = #{weight}"
else
  puts "#{name}, сначала подрасти!"
end
