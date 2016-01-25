def stock_picker(stock)
   best_day = []
   
   #to buy:
   best_day.push(stock.index(stock.min))
   #to sell:
   best_day.push(stock.index(stock.max))
   profit = stock.max - stock.min
   
    puts "The best day to buy is day #{best_day[0]} for $#{stock.min}."
    puts "The best day to sell is day #{best_day[1]} for $#{stock.max}."
    puts "Your profit is $#{profit}"
end

stock_picker([17,3,6,9,15,8,6,1,10])
# best day to buy: 7
# best day to sell: 0
# profit: 16