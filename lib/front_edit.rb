require 'front_edit/erb'

module FrontEdit
  extend self

  def rel_path(path)
    path.sub(Rails.root.to_s + '/', '')
  end

  def rel_paths(paths)
    paths.map {|x| rel_path(x)}
  end

  def link(x)
    s = <<-END
    <a href="/front_edit?file=#{x}">#{x}</a>
    END
    s.strip.html_safe
  end

  def entries(glob)
    Dir[Rails.root + glob].entries.map {|e| rel_path(e)}
  end

  def editables
    css = entries('public/stylesheets/**/*.css')
    js = entries('public/javascripts/**/*.js')
    views = entries('app/views/**/*.html.{erb,haml}')
    {:css => css, :views => views, :javascript => js}
  end

  def template_editable?(template)
    template.identifier.index(Rails.root.to_s) == 0 &&
      template.formats && 
      template.formats.include?(:html)
  end

end

require 'front_edit/engine'
