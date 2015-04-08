# Minimal GDX stub;  borrowed from https://github.com/kabbotta/LibGDX-and-Ruby

# Set current directory, load path and classpath so that we can run
# this in any directory.
proc {
  path = __FILE__
  path = File.readlink(path) while File.lstat(path).symlink?

  srcdir = File.absolute_path(File.dirname(path))
  
  root = File.absolute_path(File.join(srcdir, ".."))
  #puts "path=#{path}; srcdir = #{srcdir}; root = #{root}"

  Dir.chdir(root)
  $LOAD_PATH << srcdir
  $CLASSPATH << File.join(root, 'mvn_lib', 'target')
  #$CLASSPATH << File.join(root, 'assets')
}.call()

require 'imports'

require 'zbgame'

puts "Starting..."
LwjglApplication.new(ZBGame.new, "Zombie Bird", 272, 408)

