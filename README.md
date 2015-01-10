**AutoloadPath**
===================

Some time when you create a `gem` or a `Rails Engine`  you need to `require` a lot of files before the engine's declaration and well, here is where **autoload_path** can help you, it's a very simple gem that allows you to search through a folder and it's subfolders in search of files and automatically require them.

----------


Example
-------------

There are 3 files that aren't loaded in a rails project:

**lib/autoload_test/hello_world.rb**

```
puts "LOADED FROM HelloWorld"
class HelloWorld

end
```

**lib/autoload_test/core/foo.rb**


```
puts "LOADED FROM FOO"
```

**lib/autoload_test/core/bar.rb**

```
puts "LOADED FROM BAR"
```

if we try to initialize the class `HelloWorld` it will give us an error:

```
HelloWorld.new
NameError: uninitialized constant HelloWorld
  from (irb):1
  from /home/developer/.rvm/gems/ruby-2.0.0-p481@rails4/gems/railties-4.2.0/lib/rails/commands/console.rb:110:in `start'
  from /home/developer/.rvm/gems/ruby-2.0.0-p481@rails4/gems/railties-4.2.0/lib/rails/commands/console.rb:9:in `start'

```

To **require** the file of the entire folder `lib/autoload_test` we are going to use the `require_path` method

```
path =  Rails.root.join("lib", "autoload_test")
=> #<Pathname:/home/shared-data/projects/ruby/gems/autoload_demo/lib/autoload_test>
AutoloadPath.require_path path
=> LOADED FROM FOO
LOADED FROM BAR
LOADED FROM HelloWorld
hello_world = HelloWorld.new
=> #<HelloWorld:0x007fb61055bd88>

```

As you ca see we now have have required the the 3 files and now we can use it in our project

##Available Methods

###  **AutoloadPath.require_path**

This method require the files that are in the folder, it take one parameter that is the path and have 2 optional arguments that is **only** and **except** that takes an array of file paths that you want to include or exclude.

Example
-------------

```
# Include only some files

path =  Rails.root.join("lib", "autoload_test")

foo_file = File.join(path,"core", "foo.rb")

AutoloadPath.require_path path, only: [foo_file]
=> LOADED FROM FOO


# Exclude files

path =  Rails.root.join("lib", "autoload_test")

bar_file = File.join(path,"core", "bar.rb")

AutoloadPath.require_path path, except: [bar_file]
=> LOADED FROM FOO
LOADED FROM HelloWorld
```



###  **AutoloadPath.load_path**

It does the same as `AutoloadPath.require_path` but uses `load` instead of  `require`, remember that the main difference between both it's that require only  include the file **once** even if u call it multiple times, while `load` include the file **each time** you use it, so be careful when using `load`.


###  **AutoloadPath.get_files**
It returns an `Array` of files that are inside that folder

Example
-------------

```
path =  Rails.root.join("lib", "autoload_test")

AutoloadPath.get_files path
=> ["/home/shared-data/projects/ruby/gems/autoload_demo/lib/autoload_test/core/foo.rb", "/home/shared-data/projects/ruby/gems/autoload_demo/lib/autoload_test/core/bar.rb", "/home/shared-data/projects/ruby/gems/autoload_demo/lib/autoload_test/hello_world.rb"]
```

## **Copyright**

Copyright (c) 2015 Emilio Forrer. See LICENSE.txt for further details.
