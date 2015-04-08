require 'java'

require 'bigjar-1.2.0-jar-with-dependencies.jar'

java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.Game
java_import com.badlogic.gdx.graphics.GL20
java_import com.badlogic.gdx.graphics.Color
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplication
java_import com.badlogic.gdx.ScreenAdapter
java_import com.badlogic.gdx.graphics.OrthographicCamera
java_import com.badlogic.gdx.graphics.glutils.ShapeRenderer
java_import com.badlogic.gdx.math.Rectangle
java_import com.badlogic.gdx.math.Vector2
java_import com.badlogic.gdx.math.Intersector

java_import com.badlogic.gdx.graphics.Texture
java_import com.badlogic.gdx.graphics.g2d.Animation
java_import com.badlogic.gdx.graphics.g2d.TextureRegion
java_import com.badlogic.gdx.graphics.g2d.SpriteBatch
java_import com.badlogic.gdx.graphics.g2d.Sprite
java_import com.badlogic.gdx.graphics.g2d.BitmapFont

java_import com.badlogic.gdx.math.Circle
java_import com.badlogic.gdx.audio.Sound

