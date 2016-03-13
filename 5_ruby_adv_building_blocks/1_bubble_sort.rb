def bubble_sort(array)
    n = array.length
    loop do
        swapped = false
        
        (n-1).times do |i|
            if array[i] > array[i+1]
                array[i], array[i+1] = array[i+1], array[i]
                swapped = true
            end
        end
        
        break if not swapped
    end
    
    array
end

test = [3, 2, 5, 6, 1]

puts bubble_sort(test)

def bubble_sort_by(array)
    n = array.length
    loop do
        swapped = false
        
        (n-1).times do |i|
            if array[i] > array[i+1]
                array[i], array[i+1] = array[i+1], array[i]
                swapped = true
            end
        end
        
        break if not swapped
    end
    
    array
end

test = ["hi","hello","hey"]
puts bubble_sort_by(test)