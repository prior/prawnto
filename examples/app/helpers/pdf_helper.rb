class Array
  def combine(arr)
    output = []
    self.each do |i1|
      arr.each do |i2|
        output += [[i1,i2]]
      end
    end
    output
  end
end


module PdfHelper
  def recurse_bounding_box(pdf, max_depth=5, depth=1)
    box = pdf.bounds
    width = (box.width-15)/2
    height = (box.height-15)/2
    # notice the left-top corners used for the initial bounding_box argument require absolute positioning NOT relative to parent bounding box
    left_top_corners = [box.absolute_left+5, box.absolute_right-width-5].combine [
      box.absolute_top-5, box.absolute_bottom+height+5]
      left_top_corners.each do |lt|
        pdf.bounding_box(lt, :width=>width, :height=>height) do
          pdf.stroke_rectangle [0,height], width, height
          recurse_bounding_box(pdf, max_depth, depth+1) if depth<max_depth
        end
      end
  end

end
