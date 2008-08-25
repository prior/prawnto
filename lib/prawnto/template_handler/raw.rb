module Prawnto
  module TemplateHandler
    class Raw < ActionView::TemplateHandler
      include ActionView::TemplateHandlers::Compilable

      GENERATE_REGULAR_EXPRESSION = /^\s*Prawn\:\:Document\.generate(\(?)\s*([^,]*?)\s*?(\,(.*))?(\s*\)?\s+do(.*?))$/m
      RENDER_FILE_REGULAR_EXPRESSION = /(\w+)\.render_file\(?\s*(.*?)\s*\)?\s*$/

      def self.line_offset
        @@line_offset ||= template_wrapper_source.split(/^\s*yield/)[0].count("\n")
      end

      def compile(template)
        variable, source = source_cleanup template.source
        self.class.template_wrapper_source.sub(/^\s*yield/, source) + "\n#{variable}.render\n"
      end

      def source_cleanup(source)
        variable = '_pdf'
        filename_source = nil
        source.gsub! /^(\s*?)(\$LOAD_PATH)/, '\1#\2'
        source.gsub! /^(\s*?)(require\(?\s*['"]rubygems['"]\s*\)?\s*)$/, '\1#\2'
        source.gsub! /^(\s*?)(require\(?\s*['"]prawn['"]\s*\)?\s*)$/, '\1#\2'
        if (source =~ GENERATE_REGULAR_EXPRESSION)
          filename_source = $2
          source.sub! GENERATE_REGULAR_EXPRESSION, "#{variable} = Prawn::Document.new\\1\\4\\5"
        elsif (source =~ RENDER_FILE_REGULAR_EXPRESSION)
          variable = $1
          filename_source = $2
          source.sub! RENDER_FILE_REGULAR_EXPRESSION, '#\0'
        end
        source.gsub! /^(\s*)(class\s|def\s).*?\1end/m do |match|
          ::ApplicationHelper.module_eval(match)
          "\n" * match.count("\n")
        end
        source += "\n@prawnto_options.merge!(:filename=>#{filename_source})\n"
        [variable, source]
      end

    private

      # this is a dummy method to let me see code with editor's syntax goodness.
      # it is erased immediately afterwards
      # this method is never called, but instead the code is stripped out and pasted
      # as code to be run by the caller of compile method
      def template_wrapper_source_container
        @prawnto_options = controller.send :compute_prawnto_options
        # underscores are an attempt to avoid name clashes with user's local view variables

        yield
        
        #TODO: check if this really makes sense-- kept around from railspdf, but maybe not needed?
        _pragma = 'no-cache'
        _cache_control = 'no-cache, must-revalidate'
        _pragma = _cache_control = '' if request.env['HTTP_USER_AGENT'] =~ /msie/i #keep ie happy (from railspdf-- no personal knowledge of these issues)
        response.headers['Pragma'] ||= _pragma
        response.headers['Cache-Control'] ||= _cache_control
        
        response.content_type = Mime::PDF

        _inline = @prawnto_options[:inline] ? 'inline' : 'attachment'
        _filename = @prawnto_options[:filename] ? "filename=#{@prawnto_options[:filename]}" : nil
        _disposition = [_inline,_filename].compact.join(';')

        response.headers["Content-Disposition"] = _disposition if _disposition.length > 0

        #pdf.render
      end
      remove_method :template_wrapper_source_container
      
      
      # snips out source code from dummy method below (used by compile method)
      def self.template_wrapper_source
        @@template_wrapper_source ||= 
          begin
            method = 'template_wrapper_source_container'
            regex_s = '(\s*)def\s' + method + '\s*\n(.*?\n)\1end'
            source_regex = Regexp.new regex_s, Regexp::MULTILINE
            source_regex.match(File.read(__FILE__))[2]
          end
      end

    end
  end
end
