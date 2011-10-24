# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "front_edit"
  s.description = "Edit the front end of Rails apps through the browser."
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version = "0.0.1"
  s.summary = "front_edit #{s.version}"
  s.authors = ["Daniel Choi"]
  s.email = ["dhchoi@gmail.com"]
  s.add_dependency "rails", "~> 3.0.5"
end
