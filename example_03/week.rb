puts "Введите номер дня недели"
number = gets.strip.to_i

case number
  when 1
    puts 'Понедельник'
  when 2
    puts 'Вторник'
  when 3
    puts 'Среда'
  when 4
    puts 'Четверг'
  when 5
    puts 'Пятница'
  when 6
    puts 'Суббота'
  when 7
    puts 'Воскресение'
  else
    puts 'Неверный день недели'
end
