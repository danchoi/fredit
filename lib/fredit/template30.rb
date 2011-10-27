module ActionView
  class Template

    def render(view, locals, &block)
      # Notice that we use a bang in this instrumentation because you don't want to
      # consume this in production. This is only slow if it's being listened to.
      ActiveSupport::Notifications.instrument("!render_template.action_view", :virtual_path => @virtual_path) do
        if view.is_a?(ActionView::CompiledTemplates)
          mod = ActionView::CompiledTemplates
        else
          mod = view.singleton_class
        end
        method_name = compile(locals, view, mod)
        r = view.send(method_name, locals, &block)
        Fredit.add_fredit_link(self, r)
      end
    rescue Exception => e
      if e.is_a?(Template::Error)
        e.sub_template_of(self)
        raise e
      else
        raise Template::Error.new(self, view.respond_to?(:assigns) ? view.assigns : {}, e)
      end
    end

  end
end

