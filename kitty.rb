require "gosu"

class Kitty
	def initialize(window, fireprobz)
		@img = Gosu::Image.new(window, File.join(Constants::RESOURCE_DIRECTORY, "kitteh.png"), false)
		@window = window
		@fireprobz = fireprobz

		@x = rand * 360 + 460
		@t = rand * Math::PI
	end

	attr_reader :x

	def y
		Math.sin(@t) * 80 + 360
	end

	def move
		@t += 0.065
		@t = @t % (Math::PI * 2)
	end

	def fire
		Snowball.new(@window, @x + 10, y + 80, false)
	end

	def fire?
		if rand < @fireprobz
			self.fire
		end
	end

	def draw
		@img.draw(@x, y, ZOrder::Kitty)
	end
end
