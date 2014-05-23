require "gosu"

class Player
	def initialize(window)
		@image = Gosu::Image.new(window, File.join(Constants::RESOURCE_DIRECTORY, "hero.png"), false)
		@x = @y = @vel_x = @vel_y = 0.0
		@score = 0
		@health = 10
		@score = 0
	end

	def health
		@health
	end

	def take_damage(amount = 1)
		@health -= amount
	end

	def score
		@score
	end

	def cats(amount = 1)
		@score += amount
	end

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
		if ((@x >= 320 && @vel_x <= 0) || (@x <= 160 && @vel_x >=0))
			@x += @vel_x
		elsif @x < 320 && @x > 160
			@x += @vel_x
		end

		@y += @vel_y

		@vel_y *= 0.65

		@vel_x *= 0.95
	end

	def x
		@x
	end

	def y
		@y
	end

	def draw
		@image.draw(@x, @y, ZOrder::Player)
	end
end
