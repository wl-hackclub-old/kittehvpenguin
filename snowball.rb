require_relative 'circle'
require 'gosu'

class Snowball
  attr_reader :x, :y

  def initialize window
    @img = Gosu::Image.new(window, Circle.new(10), false)
    @color = Gosu::Color.new(0xffffffff)

    @x = rand * 640
    @y = rand * 480
  end

  def draw
    @img.draw(@x - @img.width / 2.0, @y - @img.height / 2.0,
        ZOrder::Snowball, 1, 1, @color)
  end
end
