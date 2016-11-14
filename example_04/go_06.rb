hash = Hash.new
hash2 = Hash.new
arr = Array.new
i = 0
sum = 0

loop do
  puts "Введите название товара"
  name = gets.chomp.to_s
  break if name == 'exit'

  puts "Введите цену за еденицу товара"
  number2 = gets.chomp.to_i

  puts "Введите колличество купленного товара"
  number3 = gets.chomp.to_i

  hash[name] = { number2 => number3 }
  arr.push(number2*number3)

  puts "Hash = #{hash}"
  puts "arr = #{arr}"
  puts "Сумма за #{name} = #{number2*number3}"

  while i < arr.length
    sum += arr[i]
    i += 1
  end
  puts "Сумма корзины = #{sum}"
end
