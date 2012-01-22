require File.expand_path("../spec_helper.rb", File.dirname(__FILE__))

describe PdfEmailer do
  describe "email_with_attachment" do
    before(:all) do
      @email = PdfEmailer.email_with_attachment.deliver 
    end
    
    it "should have the plain text on the body" do
      @email.encoded.should include "text\/plain"
      @email.encoded.should include "Please see attached PDF"
    end
    
    it "should have the PDF attached" do
      @email.encoded.should include "application\/pdf"
      @email.encoded.should include "Content-Disposition: attachment;"
      @email.encoded.should include "filename=hello_world.pdf"
    end
    
  end
end
