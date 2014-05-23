require_relative 'circle'
require 'gosu'

class Snowball
	attr_accessor :x, :y

	def initialize(window, xpos, ypos, dir)
		@img = Gosu::Image.new(window, Circle.new(10), false)
		if dir
			@color = Gosu::Color.new(0xffffffff)
		else
			@color = Gosu::Color.new(0xffffff30)
		end

		@x = xpos
		@y = ypos
		if dir
			@vel_x = 15
		else
			@vel_x = -15
		end
	end

	def move
		@x += @vel_x
	end

	# (x1, y1) is the upper left corner
	# (x2, y2) is the bottom right corner
	def clip(x1, y1, x2, y2)
		(@x < x2 && (@x + 20) > x1) && (@y < y2 && (@y + 20) > y1)
	end

	def draw
		@img.draw(@x - @img.width / 2.0, @y - @img.height / 2.0,
		          ZOrder::Snowball, 1, 1, @color)
	end
end
