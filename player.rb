require "gosu"

class Player
	def initialize(window, minx, maxx, miny, maxy)
		@image = Gosu::Image.new(window, File.join(Constants::RESOURCE_DIRECTORY, "hero.png"), false)
		@x = @y = @vel_x = @vel_y = 0.0
		@score = 0
		@health = 10

		@score = 0

		@minx = minx
		@maxx = maxx

		@miny = miny
		@maxy = maxy

		@on_ground = false
		@can_shoot = true
	end

	attr_accessor :minx
	attr_accessor :maxx
	attr_accessor :miny
	attr_accessor :maxy
	attr_accessor :can_shoot

	attr_reader :health

	attr_accessor :x, :y

	def width
		@image.width
	end

	def length
		@image.length
	end

	# we could also just have a setter then do @player.health =- blah
	# or use attr_accessor
	def take_damage(amount = 1)
		@health -= amount
	end

	attr_reader :score

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

	def jump
		if @on_ground
			@vel_y -= 15
			@on_ground = false
		end
	end

	def move
		@x += @vel_x

		if @x < @minx
			@x = @minx
		elsif @x > @maxx - @image.width
			@x = @maxx - @image.width
		end

		@y += @vel_y

		if @y < @miny
			@y = @miny
		elsif @y > @maxy - @image.height
			@y = @maxy - @image.height
			@vel_y = 0.0
			@on_ground = true
		end

		@vel_y += 0.5 unless @on_ground
		@vel_x *= 0.80
	end

	def draw
		@image.draw(@x, @y, ZOrder::Player)
	end
end
