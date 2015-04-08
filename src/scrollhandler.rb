
require 'scrollable'

class ScrollHandler
  attr_reader :frontGrass, :backGrass, :pipe1, :pipe2, :pipe3
  SCROLL_SPEED = -59
  PIPE_GAP = 49
  
  def initialize(gameWorld, ypos)
    @gameWorld = gameWorld
    @frontGrass = Grass.new(0, ypos, 143, 11, SCROLL_SPEED)
    @backGrass = Grass.new(@frontGrass.tailX, ypos, 143, 11, SCROLL_SPEED)
    @pipe1 = Pipe.new(210, 0, 22, 60, SCROLL_SPEED, ypos)
    @pipe2 = Pipe.new(pipe1.tailX + PIPE_GAP, 0, 22, 70, SCROLL_SPEED, ypos)
    @pipe3 = Pipe.new(pipe2.tailX + PIPE_GAP, 0, 22, 60, SCROLL_SPEED, ypos)
  end

  def onRestart
    @frontGrass.onRestart(0, SCROLL_SPEED)
    @backGrass.onRestart(@frontGrass.tailX, SCROLL_SPEED)
    @pipe1.onRestart(210, SCROLL_SPEED)
    @pipe2.onRestart(@pipe1.tailX + PIPE_GAP, SCROLL_SPEED)
    @pipe3.onRestart(@pipe2.tailX + PIPE_GAP, SCROLL_SPEED)
  end
    
  def update(delta)
    # Update our objects
    @frontGrass.update(delta)
    @backGrass.update(delta)
    @pipe1.update(delta)
    @pipe2.update(delta)
    @pipe3.update(delta)

    # Check if any of the pipes are scrolled left,
    # and reset accordingly
    @pipe1.reset(pipe3.tailX + PIPE_GAP) if @pipe1.isScrolledLeft
    @pipe2.reset(pipe1.tailX + PIPE_GAP) if @pipe2.isScrolledLeft
    @pipe3.reset(pipe2.tailX + PIPE_GAP) if @pipe3.isScrolledLeft

    # Same with grass
    @frontGrass.reset(@backGrass.tailX) if @frontGrass.isScrolledLeft
    @backGrass.reset(@frontGrass.tailX) if @backGrass.isScrolledLeft
  end

  def stop
    allScrollers.each{|s| s.stop }
  end

  def collides?(bird)
    allPipes.each do |pipe|
      if !pipe.scored && pipe.x + (pipe.width / 2) < bird.x + bird.width
        @gameWorld.addScore(1)
        pipe.scored = true
        AssetLoader.coin.play
      end
    end

    return (@pipe1.collides?(bird) ||
            @pipe2.collides?(bird) ||
            @pipe3.collides?(bird))
  end

  private

  def allScrollers
    return [@frontGrass, @backGrass, @pipe1, @pipe2, @pipe3]
  end

  def allPipes
    return [@pipe1, @pipe2, @pipe3]
  end
end
