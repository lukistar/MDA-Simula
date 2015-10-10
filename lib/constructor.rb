require 'gosu'
require_relative './player'
require_relative './tile'
require_relative './sprite'
require_relative './point'
require_relative './virtual_model'

class Constructor
	def	self.create_virtual_model(image)
	
		# upside down
		top = Point.new(0, image.height-1)
		bottom = Point.new(0, 0)
		left = Point.new(image.width-1, 0)
		right = Point.new(0, 0)
		
		image.each do |pixel, x ,y|
			if pixel[3] != 0 # check alpha channel
				if top.y > y
					top.y = y
					top.x = x
				end
				if bottom.y < y
					bottom.y = y
					bottom.x = x
				end
				if left.x > x
					left.x = x
					left.y = y
				end
				if right.x < x
					right.x = x
					right.y = y
				end
			end
		end
		
		get_stats(image, top, bottom, left, right) # return instance of VirtualModel
	end
	
	# returns object with the info about the "actual object" inside an image
	def self.get_stats(image, top, bottom, left, right)
		array = [ 
 			 [top, bottom, Gosu::distance(top.x, top.y, bottom.x, bottom.y) ],
			 [top, left, Gosu::distance(top.x, top.y, left.x, left.y) ],
			 [top, right, Gosu::distance(top.x, top.y, right.x, right.y) ],
			 [bottom, left, Gosu::distance(bottom.x, bottom.y, left.x, left.y) ],
			 [bottom, right, Gosu::distance(bottom.x, bottom.y, right.x, right.y) ],
			 [left, right, Gosu::distance(left.x, left.y, right.x, right.y) ],
		]
		array.sort! {|p1, p2| p2[2] <=> p1[2]}
		
		# the radius of the optimal circle,
		# build around the "actual object" inside an image
		radius = array[0][2]/2
		center = Point.new( (array[0][0].x - array[0][1].x).abs/2 , (array[0][0].y - array[0][1].y).abs/2 )
		height = bottom.y - top.y
		width = right.x - left.x
		rectangle_center_x = left.x + width/2
		rectangle_center_y = top.y + height/2 
		# preferred_collision = height*width > radius*radius*Math::PI ? :circle : :rectangle
		preferred_collision = :rectangle
		VirtualModel.new(image, center, radius, width, height, rectangle_center_x, rectangle_center_y, preferred_collision)
	end
end
