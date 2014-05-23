require "gosu"

require_relative "circle"

class CircleMeter
	def initialize(window, color = 0xffffffff)
		@img = Gosu::Image.new(window, Circle.new(5), false)
		@color = color
	end

	def color(level)
		@color
	end

	def draw(level, xpos, ypos)
		level.times do
			@img.draw(xpos, ypos, ZOrder::UI, 1.0, 1.0, color(level))

			xpos += 12
		end
	end
end

class Health < CircleMeter
	def color(level)
		if level > 6
			return 0xff00ff00
		elsif level > 3
			return 0xffffff30
		else
			return 0xffff0000
		end
	end
end
