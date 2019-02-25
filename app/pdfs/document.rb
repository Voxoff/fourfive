class Prawn::Document
  # First attempt at monkey patching WOO
  def many_box(arg)
    text_box arg.shift(), at: :[@address_x, cursor]
    move_down @lineheight_y
    while arg.size >= 1
      many_box(arg)
    end
  end
end
