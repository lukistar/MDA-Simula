require 'gosu'
require 'rubygems'
require 'texplay'
require_relative './point'
require_relative './constructor'
require_relative './mobject'
require_relative './map'
require_relative './base_collision'
require_relative './sprite'
require_relative './player'
require_relative './unit'
require_relative 'menu'

class GameWindow < Gosu::Window
	def initialize width, height, fullscreen = false
		$window = self
		@width = width
		@height = height
		@fullscreen = fullscreen	

		super(@width, @height, @fullscreen)
		
		self.caption = "Game Demo"
		@menu = Menu.new(self)
		
		generate
	end
	
	def generate
		$map = Map.new(8000, 6000, -8000, -6000)

		@x = 32
		@y = 418
		@x2 = 456
		@y2 = 476
		@x3 = 512
		@y3 = 415

		@tile0 = Gosu::Image.new(self, '../media/tiles/tile0.bmp', false)
		@image = Gosu::Image.new(self, '../media/sprites/drabon.png', false)
		@image_right = Gosu::Image.new(self, '../media/sprites/drabon_right.png', false)
		@sprite_image = Gosu::Image.new(self, '../media/sprites/darinx.png', false)
		@sprite_image_right = Gosu::Image.new(self, '../media/sprites/darinx_right.png', false)
		@bullet = Gosu::Image.new(self, '../media/stuffs/bullet.png', false)

		@model = Constructor::create_virtual_model(@tile0)
		@player_model = Constructor::create_virtual_model(@image)
		@player_model_right = Constructor::create_virtual_model(@image_right)
		@sprite_model = Constructor::create_virtual_model(@sprite_image)
		@sprite_model_right = Constructor::create_virtual_model(@sprite_image_right)
		@jumpStone = Tile.new(true, true, @model, @x, @y)
		@jumpStone2 = Tile.new(true, true, @model, @x2, @y2)
		@jumpStone3 = Tile.new(true, true, @model, @x3, @y3)
		@jumpStone4 = Tile.new(true, true, @model, @x3+64, @y3)
		@jumpStone5 = Tile.new(true, true, @model, @x3+128, @y3)
		$player = Player.new(true, true, @player_model, 400, 300, {:turn_left => @player_model, :turn_right => @player_model_right});
		@unit = Unit.new(true, true, @sprite_model, 500, 300, {:turn_left => @sprite_model, :turn_right => @sprite_model_right}, '../media/stuffs/bullet2.png')
		$map.add(@unit)
		$map.add(@jumpStone)
		$map.add(@jumpStone2)
		$map.add(@jumpStone3)
		$map.add(@jumpStone4)
		$map.add(@jumpStone5)
		$map.add($player)
		@stoneA = Array.new
		for i in 0..42
			@stoneA[i] = Tile.new(true, true, @model, i*64-32, 568)
			$map.add(@stoneA[i])
		end
		for i in 0..11
			$map.add(Tile.new(true, true, @model, -32, i*64))
		end
		for i in 0..11
			$map.add(Tile.new(true, true, @model, 600, i*64))
		end
		@game_over = Gosu::Image.new(self, '../media/stuffs/game_over.png', false)
		
	end
	def update
		#@menu.turn_on if self.button_down(Gosu::KbEscape)
		
		if @menu.isOn
			if button_down?(@menu.lastKP)
				@menu.control_hold(@menu.lastKP)
			end
		else 
			$map.each { |object| object.update }
		end
	end

	def draw
		if @menu.isOn
			@menu.draw_menu
			return
		end
		unless @menu.isOn
			if @menu.lastKP == Gosu::KbP
				@menu.turn_on
				return
			end
		end
		$map.each { |object| object.draw }
		if !$map.include?($player)
			@game_over.draw(0, 0, 0.5)
		end
	end
	
	def button_down(id)
		@menu.catch_key(id)
	end
end
game = GameWindow.new(800, 600)
game.show
