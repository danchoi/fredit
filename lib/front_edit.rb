require 'front_edit/erb'

module FrontEdit
  extend self

  def self.rel_path(path)
    path.sub(Rails.root.to_s + '/', '')
  end

  def self.rel_paths(paths)
    paths.map {|x| rel_path(x)}
  end

  def self.link(x)
    s = <<-END
    <a href="/front_edit?file=#{x}">#{x}</a>
    END
    s.strip.html_safe
  end

  def self.entries(glob)
    Dir[Rails.root + glob].entries.map {|e| rel_path(e)}
  end

  def self.editables
    css = entries('public/stylesheets/**/*.css')
    js = entries('public/javascripts/**/*.js')
    views = entries('app/views/**/*.html.{erb,haml}')
    {:css => css, :views => views, :javascript => js}
  end

end

require 'front_edit/engine'
