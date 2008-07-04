require 'prawn'


module PrawnView

  class Prawn < ActionView::TemplateHandler
    include ActionView::TemplateHandlers::Compilable

    def self.template_setup_source
      puts "getting setup source"
      @@template_setup_source ||= 
        begin
          source_regex = Regexp.new('\s*def\stemplate_setup_source_container\s*\n(.*\n)\s*end\s*\#\#\#\s*template_setup_source_container',Regexp::MULTILINE)
          source_regex.match(File.read(__FILE__))[1]
        end
    end

    def self.line_offset
      return 0
      puts 'getting line offset'
      @@line_offset ||= self.template_setup_source.count("\n") + 2
      puts @@line_offset
      @@line_offset
    end

    def compile(template)
      setup_source = Prawn::template_setup_source

      puts ">>>>>>>>>>>>>>>>>:"
      puts setup_source
      puts "<<<<<<<<<<<<<<<<<<"
      puts template.source
      puts ">>>>>>>>>>>>>>>>>>"

      # what does this do exactly?  not sure but copied it from builder implementation
      setup_source.gsub!("controller.","controller.response.") if @view.send!(:controller).respond_to?(:response)
      
      #setup_source + 
      x = 
      "controller.response.content_type ||= Mime::PDF\n" +
      "@prawn_document_options={}\n" +
      "pdf = Prawn::Document.new(@prawn_document_options)\n" + 
      template.source +
      "\npdf.render\n"
puts ">>>"
puts x
puts ">>>"
      x
    end

    ### this is a dummy method to let me see code with editor's goodness.
    ###   this method is never called, but instead the code is stripped out and pasted
    ###   as code to be run by the caller of compile method
    def template_setup_source_container
      #TODO: blow out into proper Error class
      # this is to prevent users from wanting to kill me
      #   since these would overwrite any local variables by the same name created by the user of this plugin
      
      #TODO: test when local_assigns actually has something-- partial render?
      conflicted_variables = (local_variables-['local_assigns']).select{|v| !((eval v).nil?)}
      throw "reserved local variable: #{conflicted_variables.inspect}" if !conflicted_variables.empty?

      @prawn_document_options ||= {}

      #TODO: check if this really makes sense-- kept around from railspdf, but maybe not needed?
      pragma = 'no-cache'
      cache_control = 'no-cache, must-revalidate'
      pragma = cache_control = '' if controller.request.env['HTTP_USER_AGENT'] =~ /msie/i #keep ie happy (from railspdf-- no personal knowledge of these issues)
      
      headers = controller.headers
      headers['Pragma'] ||= pragma
      headers['Cache-Control'] ||= cache_control
      
      controller.content_type ||= Mime::PDF

      filename = @prawn_document_options[:filename]
      headers["Content-Disposition"] ||= "attachment; filename=#{filename}" if filename
      #specify filename in controller otherwise will be inline
      #TODO: verify attachment/inline behavior?  come up with solution for default naming (probably should just use railspdf way)

    end  ### template_setup_source_container  <--- keep comment there so i can use it to snip out this code easier
    
  end
end
