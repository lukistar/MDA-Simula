class Map
	attr_accessor :map
	def initialize(width = 800, height = 600, width_min = -800, height_min = -600)
		@map = Array.new()
		@width = width
		@height = height
		@width_min = width_min
		@height_min = height_min
	end	
	
	def each
		@map.each { |elem| yield elem } if block_given?
		true
	end
	
	def add(object)
		@map << object
	end
	
	def delete(object)
		@map.delete(object)
	end
	
	def outside?(object)
		object.pos_x > @width || object.pos_x < @width_min || object.pos_y > @height || object.pos_y < @height_min
	end
	
	def include?(object)
		@map.include?(object)	
	end
end
