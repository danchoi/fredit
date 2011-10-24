
module ActionView
  class Template
    module Handlers
      class ERB < Handler
        def compile(template)

          # copied from original

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

          # added by erb_edit:

          source_file = template.identifier.sub(Rails.root.to_s + '/', '')
          erb = "<div style='color:red'>#{source_file}</div> " + erb

          # end of addition

          self.class.erb_implementation.new(
            erb,
            :trim => (self.class.erb_trim_mode == "-")
          ).src
        end

      end
    end
  end
end
