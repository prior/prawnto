require 'prawn'

module PrawnView

  class PrawnView < ActionView::Base
    include ApplicationHelper

    def initialize(action_view)
      @action_view = action_view

      path = @action_view.base_path
      basename = @action_view.first_render
      extension = @action_view.finder.pick_template_extension(basename)

      @template_file = "#{path}/#{basename}.#{extension}"
      #@template_file = "#{@action_view.base_path}/#{@action_view.first_render}.#{@action_view.finder.pick_template_extension(@action_view.first_render)}" 

      # include controller's helper
      prefix = action_view.controller.class.to_s.gsub(/Controller/, '')
      self.class.send(:include, "#{prefix}Helper".constantize)
    end
    
    # returns array of options, source without option declaration, adjusted starting line number
    def extract_document_options(source)
      def set_document_options(options={}); options; end

      match = /^\s*set_document_options\s*[\s(](.*,\s*\n*)*.*[^,]\s*\n/.match(source)
      if match
        options = eval(match[0],nil,@template_file)
        [eval(match[0],nil,@template_file), match.post_match, match[0].count("\n")]
      else
        [{}, source, 1]
      end 
    end

    def render(template, local_assigns = {})
      controller = @action_view.controller
      headers = controller.headers
      
      pragma = 'no-cache'
      cache_control = 'no-cache, must-revalidate'
      pragma = cache_control = '' if controller.request.env['HTTP_USER_AGENT'] =~ /msie/i #keep ie happy (from railspdf-- no personal knowledge of these issues)
      
      headers['Pragma'] ||= pragma
      headers['Cache-Control'] ||= cache_control
      headers["Content-Type"] ||= 'application/pdf'
      headers["Content-Disposition"] ||= "attachment; filename=#{@filename}" if @filename #specify @filename in controller otherwise will be inline -- is this true?
      
      options, source, line_number = extract_document_options(template.source)

      document = Prawn::Document::new(options)
      #get the instance variables setup	    	
      controller.instance_variables.each do |v|
        document.instance_variable_set(v, controller.instance_variable_get(v))
      end
      
      document.instance_eval(source, @template_file, line_number)
      document.render
    end

    def compilable?
      false
    end
    
  end
end
