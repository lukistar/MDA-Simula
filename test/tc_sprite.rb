require './require_all'

class TestSprite < Test::Unit::TestCase
	def setup
		$window = Gosu::Window.new(800,600,false)
		$map = Map.new(800, 600)
		@image = Gosu::Image.new($window, '../media/sprites/drabon.png', false)
		@model = Constructor::create_virtual_model(@image)
		@sprite = Sprite.new(true, true, @model, 500, 500, Hash.new)
		$map.add(@sprite)
	end
	
	def test_command?
		assert(!@sprite.command?(nil))
	end
	
	def test_range_attack
		@sprite.range_attack()
		count = 0
		$map.each { |object| count+=1 }
		assert_equal(2, count)
		@sprite.range_attack()
		assert_equal(2, count)
	end
	
	def test_update
		@sprite.update()
		assert(@sprite.pos_y > 500)
		for i in 1..100
			@sprite.update()
		end
		assert(!$map.include?(@sprite))
	end
end
