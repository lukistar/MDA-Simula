require './require_all'

class TestRangeAttack < Test::Unit::TestCase
	def setup
		$window = Gosu::Window.new(800,600,false)
		$map = Map.new(800, 600)
		@image = Gosu::Image.new($window, '../media/sprites/drabon.png', false)
		@model = Constructor::create_virtual_model(@image)
		@range_attack = RangeAttack.new(true, true, @model, 500, 500, Hash.new, :right)
		@sprite = Sprite.new(true, true, @model, 100, 100, Hash.new)
		$map.add(@range_attack)
		$map.add(@sprite)
	end
	
	def test_do_collision_effect
		@range_attack.do_collision_effect(@sprite)
		assert(!$map.include?(@range_attack))
		assert(!$map.include?(@sprite))
	end
	
	def test_moving
		@range_attack.moving()
		assert(@range_attack.pos_x > 500)
	end
	
	def test_update
		@range_attack.update()
		assert(@range_attack.pos_x > 500)
		for i in 1..42
			@range_attack.update()
		end
		assert(!$map.include?(@range_attack))
	end
end
