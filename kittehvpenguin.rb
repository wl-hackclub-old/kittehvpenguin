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

		@font = Gosu::Font.new(self, Gosu::default_font_name, 20)

		@background_image = Gosu::Image.new(self, "media/bg.png", true)

		@player = Player.new(self)
		@player.warp(320, 240)
	end

	def update
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
	end

	def draw
		@background_image.draw(0, 0, ZOrder::Background)
		@player.draw
		@font.draw("Score: ", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
	end
	def button_down(id)
		if id == Gosu::KbEscape
			close
		end
	end
end

window = GameWindow.new
window.show
