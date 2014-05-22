kittehvpenguin
==============

So much cool man.

Developing
----------

Install ruby (duh) and `freeimage-devel` or correspondinging package from your package manager.

``
bundle install
``

To run:

``
ruby kittehvpenguin.rb
``

To build Windows executables:

Install `p7zip` with your package manager of choice.

Download [the RubyInstaller 7zip](http://dl.bintray.com/oneclick/rubyinstaller/ruby-1.9.3-p545-i386-mingw32.7z?direct) to `wrappers/`.

``
rake build:windows
``

It's located at `pkg/kitteh_v_penguin_{version}_WIN32/kitteh_v_penguin.exe`.
