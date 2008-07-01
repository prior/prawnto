require 'prawn'

module PrawnView

  class PrawnView < ActionView::Base
    include ApplicationHelper

    def initialize(action_view)
      @action_view = action_view

      # include controller's helper
      prefix = action_view.controller.class.to_s.gsub(/Controller/, '')
      self.class.send(:include, "#{prefix}Helper".constantize)
    end

    def render(template, local_assigns = {})
      controller = @action_view.controller
      headers = controller.headers
      
      #get the instance variables setup	    	
      controller.instance_variables.each do |v|
        instance_variable_set(v, controller.instance_variable_get(v))
      end
      
      pragma = 'no-cache'
      cache_control = 'no-cache, must-revalidate'
      pragma = cache_control = '' if controller.request.env['HTTP_USER_AGENT'] =~ /msie/i #keep ie happy (from railspdf-- no personal knowledge of these issues)
      
      headers['Pragma'] ||= pragma
      headers['Cache-Control'] ||= cache_control
      headers["Content-Type"] ||= 'application/pdf'
      headers["Content-Disposition"] ||= "attachment; filename=#{@filename}" if @filename #specify @filename in controller otherwise will be inline -- is this true?
      
      template.source =~ /^\s*options\s*=\s*(.*[^,]\s*)\n/

        .start_with? ('page_options')
      prawn = Prawn::Document::new(options)
      eval template.source, prawn, "#{@action_view.base_path}/#{@action_view.first_render}.#{@action_view.finder.pick_template_extension(@action_view.first_render)}"
      prawn.render
    end

    def compilable?
      false
    end
    
  end
end

module Prawn
  class Document
    def self.spawn_shell
      Prawn::Document.new
    def set_options(options)
      Prawn::Document.new(
       @page_start_proc = options[:on_page_start]
       @page_stop_proc  = options[:on_page_end]              
       @page_size   = options[:page_size]   || "LETTER"    
       @page_layout = options[:page_layout] || :portrait
             
       ml = options[:left_margin]   || 36
       mr = options[:right_margin]  || 36  
       mt = options[:top_margin]    || 36
       mb = options[:bottom_margin] || 36
        
       @margin_box = BoundingBox.new(
         self,
         [ ml, page_dimensions[-1] - mt ] ,
         :width => page_dimensions[-2] - (ml + mr),
         :height => page_dimensions[-1] - (mt + mb)
       )  
       
       @bounding_box = @margin_box
       
       start_new_page 
     end  
            
     # Creates and advances to a new page in the document.
     # Runs the <tt>:on_page_start</tt> lambda if one was provided at
     # document creation time (See Document.new).  
     #                                
     def start_new_page
       finish_page_content if @page_content
       @page_content = ref(:Length => 0)   
     
       @current_page = ref(:Type      => :Page, 
                           :Parent    => @pages, 
                           :MediaBox  => page_dimensions, 
                           :Contents  => @page_content,
                           :ProcSet   => font_proc,
                           :Resources => { :Font => {} } ) 
       set_current_font    
       update_colors
       @pages.data[:Kids] << @current_page
       @pages.data[:Count] += 1 
     
       add_content "q"   
       
       @y = @margin_box.absolute_top        
       @page_start_proc[self] if @page_start_proc
    end             

