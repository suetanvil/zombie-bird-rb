require 'imports.rb'

class Bird
  attr_reader :width, :height, :rotation, :boundingCircle, :isAlive
  
  def initialize(x, y, width, height)
    # Instance variables:
    @position = Vector2.new(x, y)
    @velocity = Vector2.new(0, 0)
    @acceleration = Vector2.new(0, 460)
    @rotation = 0.0
    @width = width
    @height = height
    @boundingCircle = Circle.new    # for collision detection
    @isAlive = true
  end

  def onRestart(y)
    @rotation = 0
    @position.y = y
    @velocity.x = 0
    @velocity.y = 0
    @acceleration.x = 0
    @acceleration.y = 460
    @isAlive = true
  end
  
  def update(delta)
    @velocity.add(@acceleration.cpy.scl(delta))
    @velocity.y = 200 if @velocity.y > 200

    if @position.y < -13
      @position.y = -13
      @velocity.y = 0
    end
    
    @position.add(@velocity.cpy.scl(delta))

    # Position the bounding circle around the bird
    @boundingCircle.set(@position.x + 9, @position.y + 6, 6.5)
    
    # Rotate according to velocity
    @rotation = [@rotation - 600*delta, -20].max  if @velocity.y < 0
    @rotation = [@rotation + 480*delta, 90].min   if falling? || !@isAlive
  end

  def onClick
    return unless @isAlive
    AssetLoader.flap.play
    @velocity.y -= 140
  end

  def shouldntFlap?()
    return @velocity.y > 70 || !@isAlive
  end

  def die
    @isAlive = false
    @velocity.y = 0
  end

  def decelerate
    @acceleration.y = 0
  end

  
  def x()               return @position.x;         end
  def y()               return @position.y;         end
  def falling?()        return @velocity.y > 110;   end
end
