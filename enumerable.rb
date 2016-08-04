module Enumerable

	def my_each
		array = self.to_a if self.class == Hash
		if array
			(array.length).times { |index| yield array[index][0], array[index][1] }
		else
    (self.length).times { |index| yield self[index] }
    end
    self
  end

  def my_each_with_index
    (self.length).times do |index|
    	yield self[index], index
    end
    self
  end

  def my_select
  	result = self.dup.clear
  	array = self.to_a if self.class == Hash
  	if array
  		self.my_each { |key, value| result[key] = value if (yield key, value) }
  	else
  		self.my_each { |item| result << item if (yield item) }
  	end
  	result
  end

  def my_all?
  	self.my_each { |item| return false if !(yield item) }
  	true
  end

	def my_any?
		self.my_each { |item| return true if (yield item) }
  	false
	end

	def my_none?
		self.my_each { |item| return false if (yield item) }
  	true
	end

	def my_count(element=nil)
		if element
			count = 0
			self.my_each { |item| count +=1 if item == element}
			return count
		end
		if block_given?
			count = 0
			self.my_each { |item| count +=1 if (yield item) }
			return count
		end
		self.size
	end
	
	def my_map
		array = []
		self.my_each { |item| array << (yield item) }
		array
	end


	def my_inject(element=nil)
		element ? memo = element : memo = self.to_a[0]
		if block_given?
			array = self.to_a
			(array.size).times do |index|
				memo = yield memo, array[index] unless index == 0 && memo == self.to_a[0]
				memo
			end
		end
		memo
	end

end
# end of module

#test method for my_inject
def multiply_els(array)
	array.my_inject { |product, n| product * n }
end