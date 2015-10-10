require './require_all'

class TestConstructor < Test::Unit::TestCase
	def setup
		$window = Gosu::Window.new(800,600,false)
		@image = Gosu::Image.new($window, '../media/stuffs/test_rect.png', false)
		@top = Point.new(0, 0)
		@bottom = Point.new(0, 199)
		@left = Point.new(0, 0)
		@right = Point.new(199, 199)
	end
	
	def test_create_virtual_model
		virtual_model = Constructor::create_virtual_model(@image)
		assert_equal(199/2, virtual_model.center.x)
		assert_equal(Gosu::distance(0, 0, 199, 199)/2, virtual_model.radius)
		assert_equal(@image.width-1, virtual_model.width)
		assert_equal(@image.width/2-1, virtual_model.rectangle_center_x)
		assert_equal(:rectangle, virtual_model.collision)
	end
	
	def test_get_stats
		virtual_model2 = Constructor::get_stats(@image, @top, @bottom, @left, @right)
		assert_equal(199/2, virtual_model2.center.x)
		assert_equal(Gosu::distance(0, 0, 199, 199)/2, virtual_model2.radius)
		assert_equal(@image.width-1, virtual_model2.width)
		assert_equal(@image.width/2-1, virtual_model2.rectangle_center_x)
		assert_equal(:rectangle, virtual_model2.collision)
	end
end
