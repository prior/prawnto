require "prawn"

module Prawnto
  module TemplateHandlers
    class Base
      def self.call(template)
        "_prawnto_compile_setup;" +
        "renderer = Prawnto::TemplateHandlers::Renderer.new(self);"+
        "renderer.to_pdf do; #{template.source}\nend;"
      end
    end
  end
end


