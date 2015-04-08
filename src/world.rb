
require 'bird'
require 'scrollhandler'

class GameWorld
  attr_reader :bird, :scroller, :score
  
  def initialize(midPointY)
    @midPointY = midPointY
    @currentState = :READY
    @bird = Bird.new(33, @midPointY - 5, 17, 12)
    @scroller = ScrollHandler.new(self, @midPointY + 66)
    @alive = true
    @score = 0
    @ground = Rectangle.new(0, @midPointY + 66, 136, 11)
  end

  def restart
    @currentState = :READY
    @score = 0
    @bird.onRestart(@midPointY - 5)
    @scroller.onRestart()
  end

  def isGameOver
    return @currentState == :GAMEOVER
  end

  def isReady
    return @currentState == :READY
  end

  def start
    @currentState = :RUNNING
  end
  
  def update(delta)
    return unless @currentState == :RUNNING
    
    @bird.update(delta)
    @scroller.update(delta)

    if @bird.isAlive && @scroller.collides?(@bird)
      @scroller.stop
      @bird.die
      AssetLoader.dead.play
    end

    if (Intersector.overlaps(bird.boundingCircle, @ground))
      @scroller.stop()
      @bird.die()
      @bird.decelerate()
      @currentState = :GAMEOVER
    end
  end

  def addScore(incr)
    @score += incr
  end   
end
