#Пользователь вводит поочередно название товара, цену за единицу и кол-во
#купленного товара (может быть нецелым числом). Пользователь может ввести
#произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве
#названия товара. На основе введенных данных требуетеся: Заполнить и вывести на
#экран хеш, ключами которого являются названия товаров, а значением - вложенный
#хеш, содержащий цену за единицу товара и кол-во купленного товара. Также
#вывести итоговую сумму за каждый товар. Вычислить и вывести на экран итоговую
#сумму всех покупок в "корзине".

#basket = {:goods => {:price_per_one => 1, :goods_count => 2}}

#l2-6
basket = {}

loop do 
  puts "Наполним корзинку для красной шапочки. Для вызова злого волка написать стоп"

  puts "Что хотим вкусного?"
  goods = gets.chomp
  if goods == 'стоп'
    break
  end

  puts "Сколько стоит единичка?"
  price_per_one = gets.chomp.to_f

  puts "А сколько штук?"
  goods_count = gets.chomp.to_i

  if price_per_one <= 0 || goods_count <=0
    puts "Бесплатный сыр - в мышеловке!"
  else
    basket[goods.to_sym] = {price_per_one: price_per_one, goods_count: goods_count}
  end

end

sum = 0

basket.each do | goods, value | 
  puts "В корзинке есть: #{goods}: #{value}. Сумма за вкусняшку: #{basket[goods.to_sym][:price_per_one] * basket[goods.to_sym][:goods_count]}"
  sum += basket[goods.to_sym][:price_per_one] * basket[goods.to_sym][:goods_count]
end

puts "Итого в корзинке на сумму:#{sum} вечнозелёных. Шапка не расплатится))"


