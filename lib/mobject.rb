require_relative './move.rb'
=begin
	Probaly all obejcts will inherit Mobject.
=end
class Mobject
	attr_accessor :do_collision, :solid, :virtual_model, :pos_x, :pos_y, :rectangle_x, :rectangle_y
	
	def initialize(do_collision, solid, virtual_model, pos_x, pos_y)
		@do_collision = do_collision 	# boolean
		@solid = solid 					# boolean
		@virtual_model = virtual_model  # center, radius, width, height
		@pos_x = pos_x					# position of the center
		@pos_y = pos_y					# position of the center
		if @virtual_model.collision == :rectangle
			@virtual_center_x = @virtual_model.rectangle_center_x
			@virtual_center_y = @virtual_model.rectangle_center_y
		else
			@virtual_center_x = @virtual_model.center.x
			@virtual_center_y = @virtual_model.center.y
		end
	end
	
	# every object can be "drawn"
	def draw
		@virtual_model.image.draw_rot(@pos_x + $player.camera_x, @pos_y + $player.camera_y, 0, 0,
		 @virtual_center_x.to_f/@virtual_model.image.width,
		 @virtual_center_y.to_f/@virtual_model.image.height)
	end
	
	# every object can be "update"
	def	update
		destroy()
	end
	
	def destroy
		$map.delete(self) if $map.outside?(self)
	end
end
