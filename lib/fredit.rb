if Rails.version < '3.1.0'
  require 'fredit/erb'
else
  require 'fredit/erb31'
end
require 'uri'

module Fredit
  extend self

  LINK_CSS = "margin:0;margin-top:-1em;padding:1px;font-size:10px;background-color:#a3f66c;border:1px solid #666;"

  def rel_path(path)
    path.sub(Rails.root.to_s + '/', '')
  end

  def rel_paths(paths)
    paths.map {|x| rel_path(x)}
  end

  # TODO change this to be compatible with HAML
  def link(x)
    s = %Q| <a style="#{LINK_CSS}" href="/fredit?file=#{URI.escape(x)}" target="_blank">#{x}</a> |
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

require 'fredit/engine'
