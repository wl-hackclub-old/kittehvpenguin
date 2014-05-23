#! /usr/bin/env ruby
require "gosu"

require_relative "constants"
require_relative "health"
require_relative "kitty"
require_relative "player"
require_relative "snowball"

module ZOrder
	Background, Player, Kitty, Snowball, UI = *0..4
end

class GameWindow < Gosu::Window
	def initialize
		super 1024, 640, false
		self.caption = "Teh Kittehs"

		@menu = true
		@in_game = false
		@credits = false
		@safe = true
		@game_over = false
		@difficulty = 1

		@background_image = Gosu::Image.new(self, File.join(Constants::RESOURCE_DIRECTORY, "bg.png"), true)

		@player = Player.new(self, 0, self.width / 2, 0, self.height)
		@player.warp(0, height - 100)

		@font = Gosu::Font.new(self, Gosu::default_font_name, 20)
		@health = Health.new(self)
		@snowballmeter = CircleMeter.new(self)

		@snowballs = []

		@kittysnowballs = []

		@kitty = Kitty.new(self, 0.03 * Math.sqrt(@difficulty))
	end

	def button_down(id)
		case id
		# when Gosu::KbUp
		# 	@player.take_damage 1
		# when Gosu::GpButton0
		# 	@player.take_damage 1
		# when Gosu::KbN
		# 	@kitty = Kitty.new(self, 0.05)
		when Gosu::KbSpace
			if !@game_over && @player.snowballs > 0
				@snowballs << Snowball.new(self, @player.x + @player.width - 10, @player.y + 30, true)
				@player.snowballs -= 1
			end
		when Gosu::KbR
			if @game_over
				@game_over = false
				@player = Player.new(self, 0, self.width / 2, 0, self.height)
				@player.warp(0, height - 100)
				@snowballs = []
				@kittysnowballs = []
				@kitty = Kitty.new(self, 0.03 * Math.sqrt(@difficulty))
				@difficulty = 1
			end
		end
	end

	def button_up(id)
		case id
		#Open Menu Code
		when Gosu::KbEscape
			@safe = true
			@menu = true
		end
	end

	def update
		if !@menu
			if !@game_over
				if button_down?(Gosu::KbLeft) || button_down?(Gosu::GpLeft) || button_down?(Gosu::KbA)
					@player.move_left
				end

				if button_down?(Gosu::KbRight) || button_down?(Gosu::GpRight) || button_down?(Gosu::KbD)
					@player.move_right
				end

				if button_down?(Gosu::KbUp) || button_down?(Gosu::GpUp)|| button_down?(Gosu::KbW)
					@player.jump
				end
			end

			if (snowball = @kitty.fire?)
				@kittysnowballs << snowball
			end

			@player.move
			@snowballs.each do |s|
				s.move
				if s.clip(@kitty.x, @kitty.y, @kitty.x + 240, @kitty.y + 180)
					@kitty = Kitty.new(self, 0.03 * Math.sqrt(@difficulty))
					@player.cats @difficulty
					@player.snowballs += 2 if @player.snowballs <= 30
					@player.take_damage -3
					@difficulty += 1
					s.x = 1200 # dirty hack to get it off the screen (and no longer clipping)
				end
			end

			@kitty.move
			@kittysnowballs.each do |s|
				s.move
				if s.clip(@player.x, @player.y, @player.x + 100, @player.y + 100)
					@player.take_damage 1
					s.x = -100 # dirty hack to get it off the screen (and no longer clipping)
				end
			end

			if @player.health <= 0
				@game_over = true
			end
		elsif @credits || !@safe
			if button_down? Gosu::KbEscape then
				@credits = false
				@safe = false
			end
		else
			#Menu Controls
			if button_down? Gosu::KbEnter or button_down? Gosu::KbReturn
				@menu = false
				@in_game = true
			elsif button_down? Gosu::KbEscape then
				close
			elsif button_down? Gosu::KbC
				@credits = true
			end
		end
	end

	def draw
		if !@menu
			#Drawing Actors
			@background_image.draw(0, 0, ZOrder::Background, 1.0, 1.0, @game_over ? 0xffff5555 : 0xffffffff)
			@player.draw
			@font.draw_rel("Score: #{@player.score}", width - 30, 10, ZOrder::UI, 1.0, 0, 1.0, 1.0, 0xffffff00)
			@font.draw_rel("Difficulty: #{@difficulty}", (width / 2), 10, ZOrder::UI, 0.5, 0, 1.0, 1.0, 0xffffff00)
			@font.draw("Health: ", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
			@health.draw(@player.health, 72, 13)
			@font.draw("Snowballs: ", 10, 30, ZOrder::UI, 1.0, 1.0, 0xffffff00)
			@snowballmeter.draw(@player.snowballs, 102, 33)
			@snowballs.each do |s|
				s.draw
			end
			@kitty.draw
			@kittysnowballs.each do |s|
				s.draw
			end
			if @game_over
				@font.draw_rel("You scored #{@player.score}.", (width / 2), (height / 2) - 70, ZOrder::UI, 0.5, 0.5, 3.0, 3.0, 0xffffffff) 
				@font.draw_rel("Game Over.", (width / 2), (height / 2) - 15, ZOrder::UI, 0.5, 0.5, 3.0, 3.0, 0xffff0000) 
				@font.draw_rel("Press R to restart.", (width / 2), (height / 2) + 20, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xffff0000)
			end
		elsif @credits
			#Drawing Credits
			@background_image.draw(0, 0, ZOrder::Background, 1.0, 1.0, 0xff535353)
			@font.draw_rel("Written by the 2013-2014 ACSL club for Mr Watson.", (width / 2), (height / 2) - 15, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xffffffff)
			@font.draw_rel("President: Alan Min; Vice President: Christopher Cooper", (width / 2), (height / 2) + 15, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xffffffff)
			@font.draw_rel("Secretary: Melinda Crane; Head Programmer: Sam Mercier", (width / 2), (height / 2) + 45, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xffffffff)
			@font.draw_rel("Members: Sam Craig, Linus Lee, Kristofer Rye", (width / 2), (height / 2) + 75, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xffffffff)
			@font.draw_rel("import made.with.love;", (width / 2), height - 30, ZOrder::UI, 0.5, 1.0, 1.0, 1.0, 0xffffffff)
			@font.draw_rel("System.out.println(\"Thank you so much Mr Watson!\");", (width / 2), height, ZOrder::UI, 0.5, 1.0, 1.0, 1.0, 0xffffffff)
		else
			#Drawing Menu
			@background_image.draw(0, 0, ZOrder::Background, 1.0, 1.0, 0xff535353)
			@font.draw_rel(@in_game ? "Continue (Enter)" : "Start (Enter)", (width / 2) , (height / 2) - 45, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xfff2ff00)
			@font.draw_rel("Credits (C)", (width / 2) , (height / 2), ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xfff2ff00)
			@font.draw_rel("Exit (Escape)", (width / 2) , (height / 2) + 45, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xfff2ff00)
		end
	end
end

window = GameWindow.new
window.show
