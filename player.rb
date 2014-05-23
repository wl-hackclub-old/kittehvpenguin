require "gosu"

class Player
	def initialize(window, boundl, boundr)
		@image = Gosu::Image.new(window, File.join(Constants::RESOURCE_DIRECTORY, "hero.png"), false)
		@x = @y = @vel_x = 0.0
		@score = 0
		@health = 10
		@score = 10000
		@boundl = boundl
		@boundr = boundr
	end

	attr_accessor :boundl
	attr_accessor :boundr

	attr_reader :health

	# we could also just have a setter then do @player.health =- blah
	# or use attr_accessor
	def take_damage(amount = 1)
		@health -= amount
	end

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

		@vel_x *= 0.80
	end

	def draw
		@image.draw(@x, @y, ZOrder::Player)
	end
end
