

class AssetLoaderClass
  attr_reader :texture, :bg, :grass
  attr_reader :birdAnimation, :bird, :birdDown, :birdUp
  attr_reader :skullUp, :skullDown, :bar, :playButtonUp
  attr_reader :playButtonDown, :zbLogo

  attr_reader :logoTexture, :logo
              
  attr_reader :dead, :flap, :coin
  
  attr_reader :font, :shadow
  
  def load

    # Load the sounds
    @dead, @flap, @coin = %w{dead.wav flap.wav coin.wav}.map do |fn|
      Gdx.audio.newSound(asset(fn))
    end

    # Load the fonts
    @font, @shadow = %w{text.fnt shadow.fnt}.map do |fnt|
      font = BitmapFont.new(asset(fnt))
      font.setScale(0.25, -0.25)
      font
    end

    # Load the logo
    @logoTexture = Texture.new(asset('logo.png'))
    @logoTexture.setFilter(Texture::TextureFilter::Linear,
                           Texture::TextureFilter::Linear)
    @logo = TextureRegion.new(@logoTexture, 0, 0, 512, 114)
    
    # Load the textures
    @texture = Texture.new(asset('texture.png'))
    @texture.setFilter(Texture::TextureFilter::Nearest,
                       Texture::TextureFilter::Nearest)


    @playButtonUp   = TextureRegion.new(@texture, 0, 83, 29, 16)
    @playButtonDown = TextureRegion.new(@texture, 29, 83, 29, 16)
    @playButtonUp.flip(false, true);
    @playButtonDown.flip(false, true);

    @zbLogo = TextureRegion.new(@texture, 0, 55, 135, 24);
    @zbLogo.flip(false, true);
    
    @bg = TextureRegion.new(@texture, 0, 0, 136, 43)
    @bg.flip(false, true)

    @grass = TextureRegion.new(@texture, 0, 43, 143, 11)
    @grass.flip(false, true)

    @birdDown = TextureRegion.new(@texture, 136, 0, 17, 12)
    @birdDown.flip(false, true)

    @bird = TextureRegion.new(@texture, 153, 0, 17, 12)
    @bird.flip(false, true)

    @birdUp = TextureRegion.new(@texture, 170, 0, 17, 12)
    @bird.flip(false, true)

    keyframes = [  # Yay! Java array types!
      @birdDown, @bird, @birdUp
    ].to_java(:'com.badlogic.gdx.graphics.g2d.TextureRegion')
    @birdAnimation = Animation.new(0.06, keyframes)

    @birdAnimation.setPlayMode(Animation::PlayMode::LOOP_PINGPONG)
    
    @skullUp = TextureRegion.new(@texture, 192, 0, 24, 14)
    
    @skullDown = TextureRegion.new(@skullUp)
    @skullDown.flip(false, true)

    @bar = TextureRegion.new(@texture, 136, 16, 22, 3)
    @bar.flip(false, true)
  end

  def dispose
    [@texture, @font, @shadow, @flap, @coin, @dead, @logoTexture]
      .each{ |a| a.dispose }
  end

  private

  def asset(filename)
    # Finding the asset path is a bit tricky.
    #
    # It turns out that Gdx.files.internal uses the current working
    # directory as the root of the search.  Since we do a Dir.chdir()
    # to the project root first thing, this should find the path with
    # no trouble, right?
    #
    # Well, no.  See, the JVM doesn't let you change directories.
    # JRuby (which *does* let you change directories) gets around this
    # faking it, which works fine inside JRuby but not when calling
    # pure Java libraries like GDX.
    #
    # So the following line constructs an absolute path to the asset
    # using the JRuby current directory and everything works.  Ta da!
    
    apath = File.join(Dir.pwd, 'assets', filename)
    return Gdx.files.internal(apath)
  end



  
end

AssetLoader = AssetLoaderClass.new
# Need to wait until
