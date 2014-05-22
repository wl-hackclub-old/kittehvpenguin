#! /usr/bin/env ruby
require_relative "player"
require "gosu"

module ZOrder
	Background, Stars, Player, UI = *0..3
end

class GameWindow < Gosu::Window
	def initialize
		super 640, 480, false
		self.caption = "Teh Kittehs"

		@menu = true

		@background_image = Gosu::Image.new(self, "media/bg.png", true)

		@player = Player.new(self)
		@player.warp(320, 240)

		@font = Gosu::Font.new(self, Gosu::default_font_name, 20)
	end

	def update
		if !@menu
			if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
				@player.move_left
			end
			if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
				@player.move_right
			end
			# if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
			# 	@player.accelerate
			# end
			@player.move
		else
			#Menu Controls
			if button_down? Gosu::KbEnter or button_down? Gosu::KbReturn then
				@menu = false
			elsif button_down? Gosu::KbEscape then
				close
			end
		end

	end

	def draw
		if !@menu
			#Drawing Actors
			@background_image.draw(0, 0, ZOrder::Background)
			@player.draw
			@font.draw("Score: ", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
		else
			#Drawing Menu
			@font.draw_rel("Start (enter)", (width / 2) , (height / 2) - 15, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xfff2ff00)
			@font.draw_rel("Exit (esc)", (width / 2) , (height / 2) + 15, ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xfff2ff00)
		end
	end
	def button_up(id)
		#Open Menu Code
		if id == Gosu::KbEscape
			@menu = true
		end
	end
end

window = GameWindow.new
window.show
