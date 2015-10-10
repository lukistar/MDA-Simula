require './require_all' 
 
class TestBaseCollision < Test::Unit::TestCase
	def setup
		$window = Gosu::Window.new(800,600,false)
		@image = Gosu::Image.new($window, '../media/sprites/drabon.png', false)
		@model = Constructor::create_virtual_model(@image)
		@sprite = Sprite.new(true, true, @model, 500, 500, Hash.new)
		@sprite2 = Sprite.new(true, true, @model, 500, 500, Hash.new)
		@sprite3 = Sprite.new(true, true, @model, 5000, 5000, Hash.new)
	end
	def test_circle
		assert_equal(true, @sprite.circle(@sprite2))
		assert_equal(false, @sprite3.circle(@sprite2))	
	end
	
	def test_rectangle
		assert_equal(true, @sprite.rectangle(@sprite2))
		assert_equal(false, @sprite3.rectangle(@sprite2))
	end
end
