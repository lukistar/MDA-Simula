require './require_all'

class TestPlayer < Test::Unit::TestCase
	def setup
		$window = Gosu::Window.new(800,600,false)
		$map = Map.new(800, 600)
		@image = Gosu::Image.new($window, '../media/sprites/drabon.png', false)
		@model = Constructor::create_virtual_model(@image)
		$player = Player.new(true, true, @model, 500, 500, Hash.new)
		$map.add($player)
	end
	
	def test_command?
		assert_equal(false, $player.command?(Gosu::KbR))
	end
	
	def test_down
		$player.down()
		assert($player.pos_y > 500)
		assert_equal(500 - $player.pos_y, $player.camera_y)
	end
	
	def test_up
		$player.up()
		assert($player.pos_y < 500)
		assert_equal(500 - $player.pos_y, $player.camera_y)
	end
	
	def test_right
		$player.right()
		assert($player.pos_x > 500)
		assert_equal(500 - $player.pos_x, $player.camera_x)
	end
	
	def test_left
		$player.left()
		assert($player.pos_x < 500)
		assert_equal(500 - $player.pos_x, $player.camera_x)
	end
end
