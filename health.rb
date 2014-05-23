require_relative "circle"
require "gosu"

class Health
	def initialize(window)
		@@img = Gosu::Image.new(window, Circle.new(5), false)
	end

	def draw_health(health, xpos, ypos)
		if health > 6
			@color = 0xff00ff00
		elsif health > 3
			@color = 0xffffff30
		else
			@color = 0xffff0000
		end

		health.times do
			@@img.draw(xpos, ypos, ZOrder::UI, 1.0, 1.0, @color)

			xpos += 12
		end
	end
end
