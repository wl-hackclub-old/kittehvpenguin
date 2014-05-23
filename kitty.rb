require "gosu"

class Kitty
	def initialize(window)
		@kimg = Gosu::Image.new(window, File.join(Constants::RESOURCE_DIRECTORY, "kitteh.png"), false)

		@x = 420
		@t = rand * Math::PI
	end

	def move
		@t += 0.05
		@t = @t % (Math::PI * 2)
	end

	def draw
		@kimg.draw(@x, Math.sin(@t)*120+140, ZOrder::Kitty)
	end
end
