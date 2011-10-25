module ActionView
  class Template
    module Handlers
      class ERB 
        def call(template)
          if template.source.encoding_aware?
            # First, convert to BINARY, so in case the encoding is
            # wrong, we can still find an encoding tag
            # (<%# encoding %>) inside the String using a regular
            # expression
            template_source = template.source.dup.force_encoding("BINARY")

            erb = template_source.gsub(ENCODING_TAG, '')
            encoding = $2

            erb.force_encoding valid_encoding(template.source.dup, encoding)

            # Always make sure we return a String in the default_internal
            erb.encode!
          else
            erb = template.source.dup
          end

          # begin Fredit patch

          if Fredit.template_editable?(template)
            source_file = Fredit.rel_path template.identifier
            edit_link = "<div style='color:red'>#{Fredit.link(source_file)}</div> "
            if erb =~ /^\s*<!DOCTYPE/ && erb =~ /<body[^>]*>/
              erb = erb.sub(/<body[^>]*>/, '\&' + edit_link)
            else
              erb = edit_link + erb
            end
          end

          # end Fredit patch


          self.class.erb_implementation.new(
            erb,
            :trim => (self.class.erb_trim_mode == "-")
          ).src

        end

      end
    end
  end
end

