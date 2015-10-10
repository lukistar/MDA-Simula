require_relative './sprite'
require_relative './mobject'
require_relative './move.rb'
require_relative './base_collision'
require_relative './stat'
require 'time'

class Unit < Sprite
	def command?(key)
		@next_command == key
	end
	
	def update
		ai()
		moving()
		destroy()
	end
	
	def ai
		if $player.pos_y >= @pos_y-20 && $player.pos_y <= @pos_y+20
			distance = @pos_x - $player.pos_x
			if (distance < 0 && @direction == :right) || (distance > 0 && @direction == :left)
				@next_command = Gosu::KbR
			end
		else
			@next_command = Gosu::KbLeft if @direction == :left
			@next_command = Gosu::KbRight if @direction == :right
		end
	end
end
