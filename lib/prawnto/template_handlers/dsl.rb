module Prawnto
  module TemplateHandlers
    class Dsl < Base
      
      def compile(template)
        "logger.warn local_variables;" +
        "z = _prawnto_compile_setup(true);" +
        "logger.warn local_assigns;" + 
        "pdf = Prawn::Document.new(@prawnto_options[:prawn]);" + 
        "pdf.instance_eval do; #{template.source}\nend;" +
        "pdf.render;"
      end

    end
  end
end


