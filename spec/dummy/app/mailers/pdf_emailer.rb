class PdfEmailer < ActionMailer::Base
  helper :application
  default from: "from@example.com"
  
  def email_with_attachment
    @x = 1
    
    attachments["hello_world.pdf"] = render("test/default_render", :format => :pdf)
    mail :subject => "Hello", :to => "test@test.com" do |format|
      format.text
    end
  end
  
end
