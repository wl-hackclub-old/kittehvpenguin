#! /usr/bin/env ruby
require_relative "player"
require "gosu"

class GameWindow < Gosu::Window
	def initialize
		super 640, 480, false
		self.caption = "Teh Kittehs"

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
		@player.draw
		@background_image.draw(0, 0, 0)
	end
	def button_down(id)
		if id == Gosu::KbEscape
			close
		end
	end
end

window = GameWindow.new
window.show
