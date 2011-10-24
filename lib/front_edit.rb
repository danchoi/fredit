require 'front_edit/erb'

module FrontEdit

  def self.rel_path(path)
    path.sub(Rails.root.to_s + '/', '')
  end

  def self.link(path)
    x = rel_path path
    s = <<-END
    <a href="/front_edit?file=#{x}">#{x}</a>
    END
    s.strip.html_safe
  end

end

require 'front_edit/engine'
