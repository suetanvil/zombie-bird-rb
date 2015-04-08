
require 'imports'
require 'screens'

class SplashScreen < ScreenAdapter

  def initialize(game)
    super() # superclass expects a 0-argument constructor
    @game = game
    @sprite = nil
    @batcher = nil
    @count = 0
  end

  def show
    @sprite = Sprite.new(AssetLoader.logo)
    @sprite.setColor(1, 1, 1, 1)

    width = Gdx.graphics.getWidth
    height = Gdx.graphics.getHeight
    desiredWidth = width * 0.7
    scale = desiredWidth / @sprite.getWidth

    @sprite.setSize(@sprite.getWidth * scale, @sprite.getHeight * scale)
    @sprite.setPosition((width / 2) - @sprite.getWidth/2, 
                        height/2 - @sprite.getHeight/2)
    @batcher = SpriteBatch.new()
  end

  def render(delta)
    Gdx.gl.glClearColor(1, 1, 1, 1)
    Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT)
    @batcher.begin
    @sprite.draw(@batcher)
    @batcher.end()

    # Instead of using the Tween callback, we just wait for a couple
    # of seconds to pass
    @count += delta
    @game.setScreen(GameScreen.new()) if @count >= 2.0
  end
end
