require 'gosu'

module Base_collision
	def circle(object)
		x1 = self.pos_x
		y1 = self.pos_y
		x2 = object.pos_x
		y2 = object.pos_y
		r1 = self.virtual_model.radius
		r2 = object.virtual_model.radius
		(Gosu::distance(x1, y1, x2, y2).abs - (r1 + r2) ) > 0 ? false : true
	end
	
	def rectangle(object)
		top = self.pos_y - self.virtual_model.height/2
		bottom = self.pos_y + self.virtual_model.height/2
		left = self.pos_x - self.virtual_model.width/2
		right = self.pos_x + self.virtual_model.width/2
		
		top_2 = object.pos_y - object.virtual_model.height/2
		bottom_2 = object.pos_y + object.virtual_model.height/2
		left_2 = object.pos_x - object.virtual_model.width/2
		right_2 = object.pos_x + object.virtual_model.width/2
		
		outside_top = top > bottom_2
		outside_bottom =  bottom < top_2
		outside_left = left > right_2
		outside_right = right < left_2
		
		!(outside_top || outside_bottom || outside_left || outside_right)
	end
end
