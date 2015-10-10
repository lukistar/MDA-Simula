require_relative './sprite'

class Player < Sprite
	attr_accessor :camera_x, :camera_y
	def initialize(do_collision, solid, virtual_model, pos_x, pos_y, animations, range_attack_image = '../media/stuffs/bullet.png')
		super(do_collision, solid, virtual_model, pos_x, pos_y, animations, range_attack_image = '../media/stuffs/bullet.png')
		@camera_x = 0
		@camera_y = 0
	end
	def command?(key)
		$window.button_down?(key)   
	end
	def left
		@pos_x-=@velocity_x
		@camera_x+=@velocity_x
		look(:left)
	end
	
	def right
		@pos_x+=@velocity_x
		@camera_x-=@velocity_x
		look(:right)
	end
	
	def up
		@pos_y-=@velocity_y
		@camera_y+=@velocity_y
	end
	
	def down
		@pos_y+=@velocity_y
		@camera_y-=@velocity_y
	end
end
