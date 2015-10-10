require_relative './mobject'
require_relative './move.rb'
require_relative './base_collision'
require_relative './stat'
require 'time'

class Sprite < Mobject
	include Move
	include Base_collision
	
	attr_accessor :move_distance
	
	def initialize(do_collision, solid, virtual_model, pos_x, pos_y, animations, range_attack_image = '../media/stuffs/bullet.png')
		super(do_collision, solid, virtual_model, pos_x, pos_y)
		@stat = Stat.new
		@move_distance = @stat.ms
		@animations = animations
		@virtual_model = @virtual_model
		self.init	# initialize some instance variables
		@range_attack_image = Gosu::Image.new($window, range_attack_image, true)
		@range_attack_model = Constructor.create_virtual_model(@range_attack_image)
		@last_attack_time = Time.now.usec
	end
	
	def update
		moving()
		destroy()
	end
	
	def command?(key)
		false
	end
	
	def range_attack
		if (Time.now.to_f - @last_attack_time > @stat.as)
			@last_attack_time = Time.now.to_f
			pos = 0
			pos = @pos_x - (@virtual_model.width/2+@range_attack_model.width/2) if @direction == :left
			pos = @pos_x + (@virtual_model.width/2+@range_attack_model.width/2) if @direction == :right
	
			range_attack = RangeAttack.new(true, false, @range_attack_model, pos, @pos_y, Hash.new, @direction)
			$map.add(range_attack)
		end
	end
end

class RangeAttack < Sprite
	def initialize(do_collision, solid, virtual_model, pos_x, pos_y, animations, direction)
		super(do_collision, solid, virtual_model, pos_x, pos_y, animations)
		@direction = direction
		@velocity_x = 15 * @scale_x
		@velocity_y = 15 * @scale_y
	end
	
	def do_collision_effect(object)
		$map.delete(object)
		$map.delete(self)
	end
	
	def update
		self.moving()
		self.destroy()
	end
	
	def moving
		move(@direction)
	end
end
