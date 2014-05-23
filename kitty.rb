require "gosu"

class Kitty
	def initialize(window)
		@img = Gosu::Image.new(window, File.join(Constants::RESOURCE_DIRECTORY, "kitteh.png"), false)
		@window = window

		@x = rand * 320
		@t = rand * Math::PI
	end

	attr_reader :x

	def width
		@img.width
	end

	def height
		@img.height
	end

	def y
		Math.sin(@t) * 40 + 180
	end

	def move
		@t += 0.065
		@t = @t % (Math::PI * 2)
	end

	def draw
		@img.draw(@x, y, ZOrder::Kitty)
	end
end
