#! /usr/bin/env ruby
require_relative "player"
require_relative "health"
require_relative "constants"
require_relative "snowball"
require_relative "kitty"
require "gosu"

module ZOrder
	Background, Snowball, Player, Kitty, UI = *0..4
end

class GameWindow < Gosu::Window
	def initialize
		super 1024, 640, false
		self.caption = "Teh Kittehs"

		@menu = true
		@in_game = false
		@credits = false
		@safe = true
		@can_shoot = true

		@background_image = Gosu::Image.new(self, File.join(Constants::RESOURCE_DIRECTORY, "bg.png"), true)

		@player = Player.new(self, 0, self.width, 0, self.height)
		@player.warp(0, 0)

		@font = Gosu::Font.new(self, Gosu::default_font_name, 20)
		@health = Health.new(self)

		@snowballs = []

		@kitty = Kitty.new(self)
	end

	def update
		if !@menu
			if button_down?(Gosu::KbLeft) || button_down?(Gosu::GpLeft) || button_down?(Gosu::KbA)
				@player.move_left
			end

			if button_down?(Gosu::KbRight) || button_down?(Gosu::GpRight) || button_down?(Gosu::KbD)
				@player.move_right
			end

			if button_down?(Gosu::KbW)
				@player.jump
			end

			if button_down? Gosu::KbSpace then
				if @can_shoot
					@snowballs[@snowballs.length] = Snowball.new(self, @player.x + 20, @player.y + 30, true)
					@can_shoot = false
				end
			end

			@player.move
			@snowballs.each do |s|
				s.move
			end

			@kitty.move
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
			@background_image.draw(0, 0, ZOrder::Background)
			@player.draw
			@font.draw_rel("#{@player.score}", self.width - 10, 30, ZOrder::UI, 1.0, 1.0, 1.0, 1.0, 0xffffff00)
			@font.draw("Health: ", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
			@health.draw_health(@player.health, 72, 13)
			@snowballs.each do |s|
				s.draw
			end
			@kitty.draw
		elsif @credits
			#Drawing Credits
			@background_image.draw(0, 0, ZOrder::Background, 1.0, 1.0, 0xff535353)
			@font.draw_rel("Written by the 2013-2014 ACSL club for Mr Watson.", (width / 2), (height / 2) - 15, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xffffffff)
			@font.draw_rel("President: Alan Min; Vice President: Christopher Cooper", (width / 2), (height / 2) + 15, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xffffffff)
			@font.draw_rel("Secretary: Melinda Crane; Head Programmer: Sam Mercier", (width / 2), (height / 2) + 45, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xffffffff)
			@font.draw_rel("Members: Sam Craig, Linus Lee, Kristofer Rye", (width / 2), (height / 2) + 75, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xffffffff)
		else
			#Drawing Menu
			@background_image.draw(0, 0, ZOrder::Background, 1.0, 1.0, 0xff535353)
			@font.draw_rel(@in_game ? "Continue (Enter)" : "Start (Enter)", (width / 2) , (height / 2) - 45, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xfff2ff00)
			@font.draw_rel("Credits (C)", (width / 2) , (height / 2), ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xfff2ff00)
			@font.draw_rel("Exit (Escape)", (width / 2) , (height / 2) + 45, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xfff2ff00)
		end
	end

	def button_down(id)
		case id
		when Gosu::KbUp
			@player.take_damage 1
		when Gosu::GpButton0
			@player.take_damage 1
		end
	end

	def button_up(id)
		case id
		#Open Menu Code
		when Gosu::KbEscape
			@safe = true
			@menu = true
		when Gosu::KbSpace
			@can_shoot = true
		end
	end
end

window = GameWindow.new
window.show
