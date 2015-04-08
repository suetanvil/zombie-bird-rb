
require 'imports'

class Scrollable
  attr_reader :isScrolledLeft, :width, :height
  
  def initialize(x, y, width, height, scrollSpeed)
    @position = Vector2.new(x, y)
    @velocity = Vector2.new(scrollSpeed, 0)
    @width = width
    @height = height
    @isScrolledLeft = false
  end

  def update(delta)
    @position.add(@velocity.cpy.scl(delta))
    @isScrolledLeft = (@position.x + @width < 0)
  end

  def reset(newX)
    @position.x = newX
    @isScrolledLeft = false
  end

  def stop
    @velocity.x = 0
  end
  
  def x()       return @position.x;         end
  def y()       return @position.y;         end
  def tailX()   return @position.x + width; end
end


class Pipe < Scrollable
  attr_reader :skullUp, :skullDown, :barUp, :barDown
  attr_accessor :scored
  
  VERTICAL_GAP  = 45
  SKULL_WIDTH   = 24
  SKULL_HEIGHT  = 11

  def initialize(x, y, width, height, scrollSpeed, groundY)
    super(x, y, width, height, scrollSpeed)

    @skullUp = Rectangle.new
    @skullDown = Rectangle.new
    @barUp = Rectangle.new
    @barDown = Rectangle.new
    @groundY = groundY
    @scored = false
  end

  def onRestart(x, scrollSpeed)
    @velocity.x = scrollSpeed
    reset(x)
  end
  
  def reset(newX)
    super(newX)
    @height = rand(90)+15
    @scored = false
  end

  def update(delta)
    super(delta)

    # The set() method allows you to set the top left corner's x, y
    # coordinates,
    # along with the width and height of the rectangle
    @barUp.set(@position.x, @position.y, @width, @height)
    @barDown.set(@position.x, @position.y + @height + VERTICAL_GAP, @width,
                 @groundY - (@position.y + @height + VERTICAL_GAP))

    # Our skull width is 24. The bar is only 22 pixels wide. So the skull
    # must be shifted by 1 pixel to the left (so that the skull is centered
    # with respect to its bar).
        
    # This shift is equivalent to: (SKULL_WIDTH - width) / 2
    @skullUp.set(@position.x - (SKULL_WIDTH - @width) / 2,
                 @position.y + @height - SKULL_HEIGHT,
                 SKULL_WIDTH, SKULL_HEIGHT)
    @skullDown.set(@position.x - (SKULL_WIDTH - @width) / 2, @barDown.y,
                   SKULL_WIDTH, SKULL_HEIGHT);
  end

  def collides?(bird)
    #puts "bird=#{@bird}; pos=#{@position}"
    return unless @position.x < bird.x + bird.width
    return (Intersector.overlaps(bird.boundingCircle, @barUp)      ||
            Intersector.overlaps(bird.boundingCircle, @barDown)    ||
            Intersector.overlaps(bird.boundingCircle, @skullUp)    ||
            Intersector.overlaps(bird.boundingCircle, @skullDown))
  end
end

class Grass < Scrollable
  def onRestart(x, scrollSpeed)
    @position.x = x
    @velocity.x = scrollSpeed
  end
end
