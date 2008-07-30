require 'test/unit'
require File.expand_path(File.join(File.dirname(__FILE__), '../../../../config/environment'))


class PrawntoTest < Test::Unit::TestCase
  def test_template_setup_source
    # maybe test that you can eval source without errors (after mocha-ing up some objects?
  end

  def test_template_line_offset
    assert Prawnto::Prawn.line_offset > 1
  end

  # TODO: perhaps also test that @prawn_document_options affects Prawn::Document's initial settings-- though seems like might be kinda pointless/redundant

  #TODO: partial possibilities?
end

