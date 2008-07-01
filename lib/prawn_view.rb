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
      
      prawn = Prawn::Document.new
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
    def set_options(options)

