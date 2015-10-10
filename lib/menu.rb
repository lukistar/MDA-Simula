require 'rubygems'
require 'gosu'

class Menu

TIME_INTERVAL = 24	
	
@isOn

@menuPos
@menuSeq
@playlist

@window

@lastKP #last key press
@keyHold = false #is key currently being held?
@holdC
@lockC #lock counter

attr_accessor :lastKP, :isOn

attr_accessor :menu_active

	def initialize(window)
		@window = window
		@menuPos = 0
		@menuSeq = seq_init
		@playlist = Gosu::Song.new(@window, '../media/menu/title_screen.ogg');
		@playlist.play
		@moveSound = Gosu::Sample.new(@window, '../media/menu/sfx.ogg')
		@lockC = 0
		@menu_active = true
		
		@isOn = true
	end
	
	def key_check(key)
		
		if key == @lastKP
			@keyHold = true
		else @keyHold = false
		end
	end
	
	def catch_key(key)
		@lastKP = key
		if key == Gosu::KbReturn
			self.apply_option
			return
		end
		self.reposition(key)
		@keyDown = false
	end
	
	def control_hold(key) #key being currently held
		self.key_check(key)
		unless @keyHold
			@holdC = 0
			return
		end
		unless holdLocked?
			if key == Gosu::KbEnter
				apply_option
				return
			end
			reposition(key)
		end			
	end
	
	def reposition(key)
		if @isOn
			@moveSound.play(1,1)
			if key == Gosu::KbA or key == Gosu::KbW
				@menuPos -= 1
			elsif key == Gosu::KbD or key == Gosu::KbS
				@menuPos += 1
			elsif key == Gosu::KbEscape 
				self.turn_off
			end
			if @menuPos == -1
				@menuPos = 3
				return
			elsif @menuPos == 4
				@menuPos = 0
			end
		end
	end
	
	def apply_option()
		if @isOn
			case @menuPos
			when 0
				@isOn = false
				return
			when 1
				return
			when 2
				return
			when 3
				@window.close
			end
		end
	end
		
		
	def draw_menu
		@menuSeq[@menuPos].draw(0,0, 255)
	end
		
	def seq_init
		pictures = Array.new(4)
		pictures[0] = Gosu::Image.new(@window, '../media/menu/new game.png', true)
		pictures[1] = Gosu::Image.new(@window, '../media/menu/load game.png', true)
		pictures[2] = Gosu::Image.new(@window, '../media/menu/highscores.png', true)
		pictures[3] = Gosu::Image.new(@window, '../media/menu/exit.png', true)
		return pictures
	end
	
	def plist_init
		playlist = Gosu::Song.new(@window, '../media/menu/train-interior-1.wav');
	end
	
	def  holdLocked?		
		@lockC += 1
		if @lockC >= 24
			@lockC = 0
			return false
		end
		return true
	end
	
	def turn_on
		@playlist.play
		@isOn = true
	end
	
	def turn_off
		@playlist.stop
		@isOn = false
	end
		
	
end
