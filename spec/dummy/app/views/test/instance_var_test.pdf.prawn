text "Complex Example"
text "@x = #{@x}"
@x = 2
text x_output_helper

if @x.to_s != x_output_helper
  raise "Variable did not carry over"
end

set_x_to_3_in_helper

if @x != 3
  raise "Variable did not carry over"
end

