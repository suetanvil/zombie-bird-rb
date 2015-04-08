# Zombie Bird (in JRuby)

This is (most of) the Zombie Bird game written for the LibGDX tutorial
at <http://www.kilobolt.com/introduction.html>, re-written using
JRuby.  It only works on the desktop--feel free to add Android or iOS
support yourself.

I wrote it to familiarize myself with libGDX and to use as a starting
point for other projects.  Feel free to do the same.

## Pros

* Written in Ruby instead of Java
* Includes a Maven project that will fetch all of LibGDX for you


## Cons

* Desktop only
* Nothing in place for making a shippable .jar file

## To run

1. Install maven and a JDK (I use versions 3.2.3 and 1.8.0_25).
2. Install JRuby (I use 1.7.19)
3. Clone this repo and `cd` to it.
4. Build the dependencies:
   `(cd mvn_lib; mvn clean package)`
5. Run:
   `jruby src/main.rb`














