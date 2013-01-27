module Prawnto
  module TemplateHandlers
    class Dsl < Base
      
      def call(template)
        "_prawnto_compile_setup(true);" +
        "pdf = Prawn::Document.new(@prawnto_options[:prawn]);" + 
        "pdf.instance_eval do; #{template.source}\nend;" +
        "raw pdf.render;"
      end

    end
  end
end


