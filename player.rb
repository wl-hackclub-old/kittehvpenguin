require 'gosu'
class Player
	def initialize(window, boundl, boundr)
		@image = Gosu::Image.new(window, "media/hero.png", false)
		@x = @y = @vel_x = 0.0
		@score = 0
		@health = 10
		@score = 10000
		@boundl = boundl
		@boundr = boundr
	end

	attr_accessor :boundl
	attr_accessor :boundr

	attr_accessor :health

	attr_reader :score

	def warp(x, y)
		@x, @y = x, y
	end

	def move_left
		@vel_x -= 2
	end

	def move_right
		@vel_x += 2
	end

	def move
		@x += @vel_x

		if @x < @boundl
			@x = @boundl
		elsif @x > @boundr
			@x = @boundr
		end

		@vel_x *= 0.95
		puts @x
	end

	def draw
		@image.draw(@x, @y, ZOrder::Player)
	end
end
