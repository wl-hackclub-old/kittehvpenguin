require "gosu"

class Enemy < Player
	def initialize(window, fireprobz, teachernum)
		@image = Gosu::Image.new(window, File.join(Constants::RESOURCE_DIRECTORY, teachernum == 1 ? "teacher1.png" : "teacher2.png"), false)
		@window = window
		@fireprobz = fireprobz

		@x = rand * 320 + 320
		@y = -@image.height
		@vel_x = @vel_y = 0.0

		@minx = window.width / 2
		@maxx = window.width

		@miny = -@image.height
		@maxy = window.height

		@on_ground = false
	end

	attr_reader :x
	attr_reader :y

	def width
		@image.width
	end

	def height
		@image.height
	end

	def playerfire
		if rand < 0.3
			jump
		end
	end

	def move?
		if rand < 0.01
			@vel_x += 4
		end
		if rand < 0.01
			jump
		end
		move
	end

	def fire
		@vel_x -= rand
		Snowball.new(@window, @x + 10, y + 40, false)
	end

	def fire?
		if rand < @fireprobz
			self.fire
		end
	end

	def draw
		@image.draw(@x, y, ZOrder::Enemy)
	end
end
