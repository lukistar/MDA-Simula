require_relative './global'

module Move
	def init
		@oposite_move = {:up => :down, :down => :up, :left => :right, :right => :left}
		
		@collision_effect
		@field_effects = Array.new
		
		@jumping = false
		
		@direction = :right
	
		@speed = @move_distance
	
		@gravity = Global::GRAVITY
		
		@scale_x = Math.cos(0 * Math::PI / 180)
		@scale_y = Math.sin(90 * Math::PI / 180)
		
		@velocity_x = @speed*@scale_x	
		@velocity_y = 3*@speed*@scale_y
	end
	
	def moving
		# while the jumping is active, the object cannot fall
		if @jumping
			self.down
			if try_move? # if the move is successful
				self.do_field_effects()
				
				@velocity_y+=@gravity
			else # the object had collision with the ground or with the roof
				self.do_collision_effects() 
				self.up
				@velocity_y = @speed*@scale_y # reset to 0
				@jumping = false
			end
		else # the object tries to fall
			self.down
			if !try_move?
				self.do_collision_effects()
				self.up
			else
				self.do_field_effects()
			end
			if self.command?(Gosu::KbSpace) # new jumping is assigned
				@velocity_y = -20
				@jumping = true
			end
		end
		move(:left ) if self.command?(Gosu::KbLeft)
		move(:right) if self.command?(Gosu::KbRight)
		look(:up) if self.command?(Gosu::KbDown)
		look(:down) if self.command?(Gosu::KbUp)
		range_attack() if self.command?(Gosu::KbR)
	end
    
 	def move(move_type)
		self.method(move_type).call
		if try_move?
			self.do_field_effects()
		else
			self.do_collision_effects()
			self.method(@oposite_move[move_type]).call	
		end
	end
	
	def try_move?
		$map.each do |object|
			if object.do_collision && self != object
				if object.solid
					if self.method(object.virtual_model.collision).call(object)
						@collision_effect = object
						return false
					end
				else
					if self.method(object.virtual_model.collision).call(object) 
						@field_effects << object
					end 
				end
			end
		end
	end
	
	def do_field_effects
		@field_effects.each do |effect|
			self.do_collision_effect(effect) if self.respond_to?(:do_field_effect)
			effect.do_collision_effect(self) if effect.respond_to?(:do_field_effect)
		end
		@field_effects.clear
	end
	
	def do_collision_effects
		if @collision_effect != nil
			self.do_collision_effect(@collision_effect) if self.respond_to?(:do_collision_effect)
			@collision_effect.do_collision_effect(self) if @collision_effect.respond_to?(:do_collision_effect)
			@collision_effect = nil
		end
	end
 	
	def left
		@pos_x-=@velocity_x
		look(:left)
	end
	
	def right
		@pos_x+=@velocity_x
		look(:right)
	end
	
	def up
		@pos_y-=@velocity_y
	end
	
	def down
		@pos_y+=@velocity_y
	end
	
	def look(direction)
		@direction = direction
		#if @direction == :right
		#	@virtual_model.image = @animations[:turn_right].image
		#end
		#if @direction == :left
		#	@virtual_model.image = @animations[:turn_left].image
		#end
	end
	
	def squat
	end
end
