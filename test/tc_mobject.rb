require './require_all'

class TestMobject < Test::Unit::TestCase
	def setup
		$window = Gosu::Window.new(800,600,false)
		@image = Gosu::Image.new($window, '../media/sprites/drabon.png', false)
		@model = Constructor::create_virtual_model(@image)
		$map = Map.new(800, 600, -800, -600)
		@object_1 = Mobject.new(true, true, @model, 1000, 0)
		@object_2 = Mobject.new(true, true, @model, 1000, 0)
		$map.add(@object_1)
		$map.add(@object_2)
	end
	
	def test_destroy
		@object_1.destroy()
		assert_equal(false, $map.include?(@object_1))
	end
	
	def test_update
		@object_2.update()
		assert_equal(false, $map.include?(@object_2))
	end
end
