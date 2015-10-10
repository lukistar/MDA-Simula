require './require_all'

class TestMap < Test::Unit::TestCase
	def setup
		$window = Gosu::Window.new(800,600,false)
		@image = Gosu::Image.new($window, '../media/sprites/drabon.png', false)
		@model = Constructor::create_virtual_model(@image)
		@map = Map.new(800, 600, -800, -600)
		@object_1 = Mobject.new(true, true, @model, 0, 0)
		@object_2 = Sprite.new(true, true, @model, 0, 0, Hash.new)
		@object_3 = Sprite.new(true, true, @model, 1000, 1000, Hash.new)
		@map.add(@object_1)
		@map.add(@object_2)
	end
	
	def test_include?
		assert_equal(true, @map.include?(@object_1))
	end
	
	def test_add
		assert_equal(true, @map.include?(@object_1))
	end
	
	def test_delete
		@map.delete(@object_1)
		assert_equal(false, @map.include?(@object_1))
	end
	
	def test_outside?
		assert_equal(true, @map.outside?(@object_3))
	end
	
	def test_each
		@map.each { |object| object.pos_x = 42}
		assert_equal(42, @object_1.pos_x)
		assert_equal(42, @object_2.pos_x)
	end
end
