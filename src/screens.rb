
require 'imports'

require 'world'
require 'renderer'
require 'input'

class GameScreen < ScreenAdapter
  def initialize
    @world = nil
    @renderer = nil
    @runTime = 0.0

    screenWidth = Gdx.graphics.getWidth
    screenHeight = Gdx.graphics.getHeight
    gameWidth = 136
    gameHeight = screenHeight / (screenWidth/gameWidth)

    midPointY = (gameHeight/2).round

    @world = GameWorld.new(midPointY)
    @renderer = GameRenderer.new(@world, gameHeight, midPointY)
    Gdx.input.setInputProcessor(InputHandler.new(@world))
  end

  def render(delta)
    @runTime += delta
    @world.update(delta)
    @renderer.render(@runTime)
  end
end

