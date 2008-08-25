module Prawnto
  module TemplateHandler
    class Base < ActionView::TemplateHandler
      include ActionView::TemplateHandlers::Compilable

      def self.line_offset
        # looks for spot where binding is called-- since that is where the template is ultimately evaluated -- and that is what will give us accurate line # reporting
        @@line_offset ||= template_wrapper_source.split(/^.*=\s*binding/)[0].count("\n")
      end

      def compile(template)
        self.class.template_wrapper_source.sub(/^\s*yield/, template.source)
      end

    private

      # this is a dummy method to let me see code with editor's syntax goodness.
      # it is erased immediately afterwards
      # this method is never called, but instead the code is stripped out and pasted
      # as code to be run by the caller of compile method
      def template_wrapper_source_container
        @prawnto_options = controller.send :compute_prawnto_options
        # underscores are an attempt to avoid name clashes with user's local view variables
        
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

        _binding = nil
        pdf = Prawn::Document.new(@prawnto_options[:prawn])
        if _dsl = @prawnto_options[:dsl]
          _variable_transfer = if _dsl.kind_of?(Array)
            _dsl.map {|v| v = v[1..-1] if v[0,1]=="@"; "#{v}=@#{v};"}.join('')
          elsif _dsl.kind_of?(Hash)
            _dsl.map {|k,v| "#{k}=#{v};"}.join('')
          else
            ""
          end
          #eval _variable_transfer
          eval "x=1"
          puts x
          puts _variable_transfer
          puts "x"
          puts x
          puts "------------"
          pdf.instance_eval do
            _binding = binding; end; else; _binding = binding;  #stuck together to keep binding captures on same line so line_offset is valid in both cases
        end

        _view = <<EOS
          yield
EOS
        eval(_view,_binding)
        pdf.render
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
