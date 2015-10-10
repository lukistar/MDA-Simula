require './require_all'

class TestUnit < Test::Unit::TestCase
	def setup
		$window = Gosu::Window.new(800,600,false)
		$map = Map.new(800, 600)
		@image = Gosu::Image.new($window, '../media/sprites/drabon.png', false)
		@model = Constructor::create_virtual_model(@image)
		@unit = Unit.new(true, true, @model, 200, 500, Hash.new)
		$map.add(@unit)
		$player = Player.new(true, true, @model, 500, 300, Hash.new)
		$map.add($player)
	end
	
	def test_ai
		assert_equal(Gosu::KbRight, @unit.ai())
		$player.pos_y = 500
		assert_equal(Gosu::KbR, @unit.ai())
	end
	
	def test_update
		@unit.update()
		assert(@unit.pos_x > 200)
		$player.pos_y = 500
		@unit.update()
		count = 0
		$map.each { |object| count+=1}
		assert_equal(3, count)
		$player.pos_y = 300
		for i in 1..42
			@unit.update
		end	
		assert(!$map.include?(@unit))
	end
	
	def test_command?
		@unit.ai()
		assert(@unit.command?(Gosu::KbRight))
		$player.pos_y = 500
		@unit.ai()
		assert(@unit.command?(Gosu::KbR))
	end
end
