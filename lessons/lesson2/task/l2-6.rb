#Пользователь вводит поочередно название товара, цену за единицу и кол-во
#купленного товара (может быть нецелым числом). Пользователь может ввести
#произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве
#названия товара. На основе введенных данных требуетеся: Заполнить и вывести на
#экран хеш, ключами которого являются названия товаров, а значением - вложенный
#хеш, содержащий цену за единицу товара и кол-во купленного товара. Также
#вывести итоговую сумму за каждый товар. Вычислить и вывести на экран итоговую
#сумму всех покупок в "корзине".

#basket = {:goods => {:price => 1, :count => 2}}

#l2-6
basket = {}
sum = 0

loop do 
  puts "Наполним корзинку для красной шапочки. Для вызова злого волка написать стоп"

  puts "Что хотим вкусного?"
  goods = gets.chomp
  break if goods == 'стоп'

  puts "Сколько стоит единичка?"
  price = gets.chomp.to_f

  puts "А сколько штук?"
  count = gets.chomp.to_i

  if price <= 0 || count <=0
    puts "Бесплатный сыр - в мышеловке!"
  else
    basket[goods.to_sym] = {price: price, count: count}
    sum += basket[goods.to_sym][:price] * basket[goods.to_sym][:count]
  end

end

basket.each { | goods, price_count | puts "В корзинке есть: #{goods}, ценой в: #{price_count[:price]} уе, количеством#{price_count[:count]}. Сумма за вкусняшку: #{basket[goods.to_sym][:price] * basket[goods.to_sym][:count]}" }

puts "Итого в корзинке на сумму:#{sum} вечнозелёных. Шапка не расплатится))"
