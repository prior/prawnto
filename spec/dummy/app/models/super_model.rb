class SuperModel
  
  def to_pdf
    @x = 1
    Prawnto::ModelRenderer.to_string "test/default_render.pdf", self
  end
  
end