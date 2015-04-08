
require 'screens'
require 'splashscreen'
require 'assetloader'

class ZBGame < Game

  def create()
    AssetLoader.load()
    setScreen(SplashScreen.new(self))
  end

  def dispose
    super()
    AssetLoader.dispose()
  end

end
