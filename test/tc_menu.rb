require './require_all' 
 
class TestMenu < Test::Unit::TestCase
	def setup
		@window = Gosu::Window.new(800, 600, false)
		@menu = Menu.new(@window)
	end
	
	def test_turn_on
		@menu.turn_on()
		assert(@menu.isOn)
	end
	
	def test_turn_off
		@menu.turn_off()
		assert(!@menu.isOn)
	end
	
	def test_holdLocked?
		assert(@menu.holdLocked?)
		for i in 0...22
			@menu.holdLocked?
		end
		assert(!@menu.holdLocked?)
	end
	
	def test_plist_init
	end
	
	def test_seq_init
		pictures = @menu.seq_init()
		assert_instance_of(Array, pictures)
		assert_equal(4, pictures.size)
	end
	
	def test_key_check
		assert(@menu.key_check(@menu.lastKP))
	end
	
	def test_catch_key
		assert_equal(false, @menu.catch_key(Gosu::KbS))
		assert_equal(nil, @menu.catch_key(Gosu::KbReturn))
	end
	
	def test_apply_option
		@menu.turn_on()
		assert(!@menu.apply_option)
	end
	
	def test_reposition
		@menu.turn_off()
		assert(!@menu.reposition(nil))
		@menu.turn_on()
		assert_equal(nil, @menu.reposition(Gosu::KbA))
		assert_equal(0, @menu.reposition(Gosu::KbD))
		@menu.reposition(Gosu::KbEscape)
		assert_equal(false, @menu.isOn)
	end
end
