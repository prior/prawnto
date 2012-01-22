class PdfEmailer < ActionMailer::Base
  default from: "from@example.com"
  
  def email_with_attachment
    attachments["hello_world.pdf"] = render("test/default_render", :format => :pdf)
    
    mail :subject => "Hello", :to => "test@test.com" do |format|
      format.text { render :action => "email_with_attachment"}
    end
  end
  
end
