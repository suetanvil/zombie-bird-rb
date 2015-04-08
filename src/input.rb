require 'imports'

class InputHandler
  
  def initialize(world)
    @world = world
    @bird = @world.bird
  end
  
  def touchDown(screenX, screenY, pointer, button)
    return pressed()
  end

  def keyDown(keycode)
    return pressed()
  end

  def keyUp(keycode)                                return false;   end
  def keyTyped(character)                           return false;   end
  def touchUp(screenX, screenY, pointer, button)    return false;   end
  def touchDragged(screenX, screenY, button)        return false;   end
  def mouseMoved(screenX, screenY)                  return false;   end
  def scrolled(amount)                              return false;   end

  private

  def pressed
    @world.start if @world.isReady
    @bird.onClick()
    @world.restart if @world.isGameOver
    return true
  end
end
