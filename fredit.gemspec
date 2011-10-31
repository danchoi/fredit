# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "fredit"
  s.description = "Edit the front end of Rails apps through the browser."
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.version = "0.2.6"
  s.summary = s.description
  s.authors = ["Daniel Choi"]
  s.email = ["dhchoi@gmail.com"]
  s.homepage = "https://github.com/danchoi/fredit"

  # Including rails as a dependency seems to be redundant since this is
  # a Rails Engine, and we don't want the wrong version of rails
  # installed as a dependency.

  # s.add_dependency "rails", ">= 3.0.5"

  s.add_dependency "git"
end
