require 'prawn'


module Prawnto

  class Prawn < ActionView::TemplateHandler
    include ActionView::TemplateHandlers::Compilable

    # snips out source code from dummy method below (used by compile method)
    def self.template_setup_source
      @@template_setup_source ||= 
        begin
          method = 'template_setup_source_container'
          regex_s = '\s*def\s' + method + '\s*\n(.*\n)\s*end\s*\#+\s*' + method
          source_regex = Regexp.new regex_s, Regexp::MULTILINE
          source_regex.match(File.read(__FILE__))[1]
        end
    end

    def self.line_offset
      @@line_offset ||= (self.template_setup_source.count("\n") + 1)
    end

    # incorporates template into a string to be compiled (using a proc)
    def compile(template)
      setup_source = Prawn::template_setup_source

      # what does following line do exactly?  not sure but copied it from builder implementation  -- no longer needed since only line with "controller" is flaky anyhow
#      setup_source.gsub!("controller","controller.response") if @view.send!(:controller).respond_to?(:response)
      
      setup_source + 
      "pdf = Prawn::Document.new(@prawn_document_options)\n" + 
      template.source +
      "\npdf.render\n"
    end


    # this is a dummy method to let me see code with editor's syntax goodness.
    # it is erased immediately afterwards
    # this method is never called, but instead the code is stripped out and pasted
    # as code to be run by the caller of compile method
    def template_setup_source_container
      @prawn_document_options ||= {}

      #TODO: check if this really makes sense-- kept around from railspdf, but maybe not needed?
      ___pragma = 'no-cache'  # underscores are an attempt to avoid name clashes with user's local view variables
      ___cache_control = 'no-cache, must-revalidate'
      ___pragma = ___cache_control = '' if request.env['HTTP_USER_AGENT'] =~ /msie/i #keep ie happy (from railspdf-- no personal knowledge of these issues)
      headers['Pragma'] ||= ___pragma
      headers['Cache-Control'] ||= ___cache_control
      
      # controller.content_type ||= Mime::PDF
      # for some reason above line is not working on subsequent requests for different pdfs, but the following does-- i have no clue?
      headers['Content-Type'] ||= 'application/pdf'

      inline = @prawn_document_options[:inline]
      filename = @prawn_document_options[:filename]
      inline = inline ? 'inline' : inline==false ? 'attachment' : nil
      filename = filename ? "filename=#{filename}" : nil
      disposition = [inline,filename].compact.join(';')

      headers["Content-Disposition"] ||= disposition if disposition.length > 0
      
      #specify filename in controller otherwise will be inline
      #TODO: verify attachment/inline behavior
      #TODO: come up with solution for default naming (probably should just use railspdf way)

    end  ### template_setup_source_container  <--- keep comment there so i can use it to snip out this code easier
    remove_method :template_setup_source_container
    
  end
end
