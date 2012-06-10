module Prawnto
  module TemplateHandlers
    class Dsl < Base
      
      def compile(template)
        "view = self; @pdf.instance_eval do; #{template.source}\nend;"
      end

    end
  end
end


