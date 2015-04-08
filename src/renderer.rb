
require 'imports'


class GameRenderer
  def initialize(world, gameHeight, midPointY)
    # Fields:
    @world = world
    @cam = nil
    @shapeRenderer = nil
    @gameHeight = gameHeight
    @midPointY = midPointY
    @batcher = nil
    
    @cam = OrthographicCamera.new
    @cam.setToOrtho(true, 136, @gameHeight)

    @batcher = SpriteBatch.new()
    @batcher.setProjectionMatrix(@cam.combined)
    
    @shapeRenderer = ShapeRenderer.new()
    @shapeRenderer.setProjectionMatrix(@cam.combined)
    
    puts "Renderer: created."
  end
  
  def render(runTime)
    # Draw a black background to prevent flickering
    Gdx.gl.glClearColor(0, 0, 0, 1)
    Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT)

    # Start render
    @shapeRenderer.begin(ShapeRenderer::ShapeType::Filled)

    # Draw Background color
    @shapeRenderer.setColor(55/255.0, 80/255.0, 100/255.0, 1)
    @shapeRenderer.rect(0, 0, 136, @midPointY + 66)

    # Draw Grass
    @shapeRenderer.setColor(111/255.0, 186/255.0, 45/255.0, 1)
    @shapeRenderer.rect(0, @midPointY + 66, 136, 11)

    # Draw Dirt
    @shapeRenderer.setColor(147/255.0, 80/255.0, 27/255.0, 1)
    @shapeRenderer.rect(0, @midPointY + 77, 136, 52)
    
    # End ShapeRenderer
    @shapeRenderer.end();
    
    # Begin SpriteBatch
    @batcher.begin();
    
    # Disable transparency
    # 
    # This is good for performance when drawing images that do not
    # require transparency.
    @batcher.disableBlending()
    @batcher.draw(AssetLoader.bg, 0, @midPointY + 23, 136, 43)

    drawGrass()
    drawPipes()
    drawSkulls()
    
    @batcher.enableBlending()   # The rest needs transparency

    drawBird(runTime)
    
    drawStartText()     if @world.isReady
    drawGameOverText()  if @world.isGameOver
    drawScore()         unless @world.isReady

    # End SpriteBatch
    @batcher.end();
  end

  private

  def drawStartText
    # Draw shadow first, then text
    AssetLoader.shadow.draw(@batcher, "Touch me", (136 / 2) - (42), 76)
    AssetLoader.font.draw(@batcher, "Touch me", (136 / 2) - (42 - 1), 75)
  end
  
  def drawScore
    score = "#{@world.score}"
    xpos = 136/2 - 3*score.size
    AssetLoader.shadow.draw(@batcher, score, xpos, 12)
    AssetLoader.font.draw(@batcher, score, xpos - 1, 11)
  end
  
  def drawGameOverText
    AssetLoader.shadow.draw(@batcher, "Game Over", 25, 56)
    AssetLoader.font.draw(@batcher, "Game Over", 24, 55)
                
    AssetLoader.shadow.draw(@batcher, "Try again?", 23, 76)
    AssetLoader.font.draw(@batcher, "Try again?", 24, 75)
  end
  
  def drawBird(runTime)
    # Draw the bird.  Which icon depends on whether it's flapping or
    # falling
    bird = @world.bird
    image = bird.shouldntFlap? ?
              AssetLoader.bird :
              AssetLoader.birdAnimation.getKeyFrame(runTime)
    @batcher.draw(image, bird.x, bird.y,
                  bird.width / 2.0, bird.height / 2.0,
                  bird.width, bird.height, 1, 1, bird.rotation)
  end
  
  def drawGrass
    frontGrass = @world.scroller.frontGrass
    backGrass = @world.scroller.backGrass
    grass = AssetLoader.grass
    @batcher.draw(grass, frontGrass.x, frontGrass.y,
                  frontGrass.width, frontGrass.height)
    @batcher.draw(grass, backGrass.x, backGrass.y,
                  backGrass.width, backGrass.height)
  end

  def drawSkulls
    su, sd = AssetLoader.skullUp, AssetLoader.skullDown
    pipe1, pipe2, pipe3 = [@world.scroller.pipe1, @world.scroller.pipe2,
                           @world.scroller.pipe3]

    @batcher.draw(su, pipe1.x - 1, pipe1.y + pipe1.height - 14, 24, 14)
    @batcher.draw(sd, pipe1.x - 1, pipe1.y + pipe1.height + 45, 24, 14)

    @batcher.draw(su, pipe2.x - 1, pipe2.y + pipe2.height - 14, 24, 14)
    @batcher.draw(sd, pipe2.x - 1, pipe2.y + pipe2.height + 45, 24, 14)

    @batcher.draw(su, pipe3.x - 1, pipe3.y + pipe3.height - 14, 24, 14)
    @batcher.draw(sd, pipe3.x - 1, pipe3.y + pipe3.height + 45, 24, 14)
  end

  def drawPipes
    pipe1, pipe2, pipe3 = [@world.scroller.pipe1, @world.scroller.pipe2,
                           @world.scroller.pipe3]
    bar = AssetLoader.bar
    
    @batcher.draw(bar, pipe1.x, pipe1.y, pipe1.width, pipe1.height)
    @batcher.draw(bar, pipe1.x, pipe1.y + pipe1.height + 45,
                  pipe1.width, @midPointY + 66 - (pipe1.height + 45))

    @batcher.draw(bar, pipe2.x, pipe2.y, pipe2.width, pipe2.height)
    @batcher.draw(bar, pipe2.x, pipe2.y + pipe2.height + 45,
                  pipe2.width, @midPointY + 66 - (pipe2.height + 45))

    @batcher.draw(bar, pipe3.x, pipe3.y, pipe3.width,
                  pipe3.height)
    @batcher.draw(bar, pipe3.x, pipe3.y + pipe3.height + 45,
                  pipe3.width, @midPointY + 66 - (pipe3.height + 45))
  end
  
end
