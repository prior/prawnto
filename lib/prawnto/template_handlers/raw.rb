module Prawnto
  module TemplateHandlers
    class Raw < Base
      
      def self.call(template)
        source,filename = massage_template_source(template)
        "_prawnto_compile_setup;" +
        source
      end

      GENERATE_REGULAR_EXPRESSION = /^\s*Prawn\:\:Document\.generate(\(?)(.*?)(\,(.*))?(\s*\)?\s+do(.*?))$/m
      RENDER_FILE_REGULAR_EXPRESSION = /(\w+)\.render_file\(?(.*?)\)?\s*$/

    protected
      def massage_template_source(template)
        source = template.source.dup
        variable_name = '_pdf'
        filename = nil
        
        source.gsub! /^(\s*?)(\$LOAD_PATH)/, '\1#\2'
        source.gsub! /^(\s*?)(require\(?\s*['"]rubygems['"]\s*\)?\s*)$/, '\1#\2'
        source.gsub! /^(\s*?)(require\(?\s*['"]prawn['"]\s*\)?\s*)$/, '\1#\2'

        if (source =~ GENERATE_REGULAR_EXPRESSION)
          filename = $2
          source.sub! GENERATE_REGULAR_EXPRESSION, "#{variable_name} = Prawn::Document.new\\1\\4\\5"
        elsif (source =~ RENDER_FILE_REGULAR_EXPRESSION)
          variable_name = $1
          filename = $2
          source.sub! RENDER_FILE_REGULAR_EXPRESSION, '#\0'
        end
        source.gsub! /^(\s*)(class\s|def\s).*?\n\1end/m do |match|
          eval "class <<@run_environment; #{match}; end;"
          "\n" * match.count("\n")
        end
        source += "\n[#{variable_name}.render,#{filename}]\n"
        source
      end

    end
  end
end
