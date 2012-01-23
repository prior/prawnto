class TestController < ApplicationController

  def default_render
    @x = 1
    render :action => "default_render"
  end
  
  def dsl_render
    @x = 1
    render :action => "dsl_render"
  end
  
  def complex
    @x = 1
    render :action => "complex"
  end
    
end
