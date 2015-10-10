class VirtualModel
	attr_accessor :image, :center, :radius, :height, :width, :rectangle_center_x , :rectangle_center_y, :collision
	
	def initialize(image, center, radius, width, height, rectangle_center_x, rectangle_center_y, preferred_collision)
		@center = center
		@radius = radius
		@width, @height = width, height
		@image = image
		@rectangle_center_x = rectangle_center_x
		@rectangle_center_y = rectangle_center_y
		
		@collision = preferred_collision
	end
end
