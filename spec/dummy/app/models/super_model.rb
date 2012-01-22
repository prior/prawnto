class SuperModel
  
  def to_pdf
    @x = 1
    Prawnto::Render.to_string "test/default_render", self
  end
  
end