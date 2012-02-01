module ApplicationHelper
  def some_helper
    "this is from a helper"
  end
  
  def x_output_helper
    @x.to_s
  end
  
  def set_x_to_3_in_helper
    @x = 3
  end
  
  def yield_this_block
    yield
  end
  
end
