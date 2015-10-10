require './require_all'

class TestMove < Test::Unit::TestCase
	def setup
		$window = Gosu::Window.new(800,600,false)
		@image = Gosu::Image.new($window, '../media/sprites/drabon.png', false)
		@model = Constructor::create_virtual_model(@image)
		$map = Map.new(800, 600, -800, -600)
		@sprite = Sprite.new(true, true, @model, 500, 500, Hash.new)
		@range_attack = RangeAttack.new(true, true, @model, 499, 500, Hash.new, :right)
		@sprite_2 = Sprite.new(true, true, @model, 100, 100, Hash.new)
		$map.add(@sprite)
		$map.add(@sprite_2)
		$map.add(@range_attack)
		$player = Player.new(true, true, @model, 700, 400, Hash.new)
		$map.add($player)
	end
	
	def test_down
		@sprite.down()
		assert(@sprite.pos_y > 500)
	end
	
	def test_up
		@sprite.up()
		assert(@sprite.pos_y < 500)
	end
	
	def test_right
		@sprite.right()
		assert(@sprite.pos_x > 500)
	end
	
	def test_left
		@sprite.left()
		assert(@sprite.pos_x < 500)
	end
	
	def test_look
		assert_equal(:left, @sprite.look(:left))
	end
	
	def test_squat
	end
	
	def test_do_collision_effects
		@range_attack.update()
		assert_equal(false, $map.include?(@range_attack))
		assert_equal(false, $map.include?(@sprite))
	end
	
	def test_do_field_effects
		assert(@range_attack.do_field_effects().empty?)
	end
	
	def test_try_move?
		sprite_2 = Sprite.new(true, true, @model, 500, 500, Hash.new)
		$map.add(sprite_2)
		assert(!@sprite.try_move?)
	end
	
	def test_move
		@sprite_2.move(:up)
		assert(@sprite_2.pos_y < 100)
		@sprite.move(:up)
		assert(@sprite.pos_x == 500)
	end
	
	def test_moving
		unit = Unit.new(true, true, @model, 250, 250, Hash.new)
		unit.ai()
		unit.moving()
		assert(unit.pos_x > 250)
		assert(unit.pos_y > 250)
	end
end
