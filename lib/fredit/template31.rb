module ActionView
  class Template
    def render(view, locals, buffer=nil, &block)
      ActiveSupport::Notifications.instrument("!render_template.action_view", :virtual_path => @virtual_path) do
        compile!(view)
        r = view.send(method_name, locals, buffer, &block)
        Fredit.add_fredit_link(self, r)
      end
    rescue Exception => e
      handle_render_error(view, e)
    end
  end
end

__END__

