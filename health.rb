require 'gosu'
class Circle
  attr_reader :columns, :rows

  def initialize radius
    @columns = @rows = radius * 2
    lower_half = (0...radius).map do |y|
      x = Math.sqrt(radius**2 - y**2).round
      right_half = "#{"\xff" * x}#{"\x00" * (radius - x)}"
      "#{right_half.reverse}#{right_half}"
    end.join
    @blob = lower_half.reverse + lower_half
    @blob.gsub!(/./) { |alpha| "\xff\xff\xff#{alpha}"}
  end

  def to_blob
    @blob
  end
end

class Health
	def initialize window
		@@img = Gosu::Image.new(window, Circle.new(5), false)
	end
	def draw_health hlth, xpos, ypos
		if hlth > 6
			@color = 0xff00ff00
		elsif hlth > 3
			@color = 0xffffff30
		else
			@color = 0xffff0000
		end

		hlth.times do
			@@img.draw(xpos, ypos, ZOrder::UI, 1.0, 1.0, @color)
			xpos += 12
		end
	end

end
