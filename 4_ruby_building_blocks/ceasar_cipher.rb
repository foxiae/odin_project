def ceasar_cipher(str, num)
	lower = ('a'..'z').to_a
	upper = lower.map(&:upcase)
	ctext = Array.new
	str = str.split(" ")

	str = str.map do |word|
        word.each_char do |char|
			if lower.include?(char)
			    n = lower.index(char) + num
			    char = lower[n]
			elsif upper.include?(char)
			    m = upper.index(char) + num
			    char = upper[m]
			end
			ctext.push(char)
		end
		ctext.push(" ")
	end
	ctext.join
end

ceasar_cipher("Imma cypher text", 5)