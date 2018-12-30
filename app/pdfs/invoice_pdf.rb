class InvoicePdf < Prawn::Document
  def initialize(attributes)
    super
    @address = attributes[:address]
    @amount = attributes[:amount]
    @date = attributes[:date]
    @cart_items = attributes[:cart_items]
    @order_id = attributes[:order_id]
    invoice_data
    create
  end

  def invoice_data
    @invoice_services_data = [["Item", "Description", "Unit Cost", "Quantity", "Line Total"]]
    @cart_items.each do |item|
      @invoice_services_data << ["#{item.product.readable_name}",
        "#{item.product.specific_name}",
        "#{item.product.price}",
        "#{item.quantity} ",
        "#{item.line_cost} "]
    end
    @invoice_notes_data = [["Notes"], ["Thank you for doing business with fourfive"]]
    @invoice_services_totals_data = [
      ["Total", "£#{@amount}"],
      ["Amount Paid", "£#{@amount}"],
      ["Amount Due", "£0.00 GBP"]
    ]
    date = Date.today.strftime('%A, %b %d')
    @invoice_header_data = [ ["Receipt #", @order_id.to_s], ["Receipt Date", date], ["Amount Due", "£0.00 GBP"]]
  end

  def create
    logopath = 'logo.png'
    initial_y = cursor
    initialmove_y = 5
    address_x = 35
    invoice_header_x = 325
    lineheight_y = 12
    font_size = 10

    move_down initialmove_y

    # Add the font style and size
    font "Helvetica"
    font_size font_size

    #start with EON Media Group
    text_box "fourfive,", :at => [address_x,  cursor]
    move_down lineheight_y
    text_box "Flow Nutrition Ltd,", :at => [address_x,  cursor]
    move_down lineheight_y
    text_box "2 Victoria Square,", :at => [address_x,  cursor]
    move_down lineheight_y
    text_box "Victoria Street,", :at => [address_x,  cursor]
    move_down lineheight_y
    text_box "St. Albans, UK, N10AF", :at => [address_x,  cursor]
    move_down lineheight_y

    last_measured_y = cursor
    move_cursor_to bounds.height

    # logopath =  "#{Rails.root}/app/assets/images/small_logo.png"
    # image open("http://res.cloudinary.com/dq2kcu9ey/image/upload/v1543757174/eb8bk1ntavsaotcdmui0.png"), :vposition => :top

    # image logopath, :width => 215, :position => :right

    move_cursor_to last_measured_y

    # client address
    move_down 65
    last_measured_y = cursor

    text_box " ", :at => [address_x, cursor]
    move_down lineheight_y
    text_box @address.full_name, :at => [address_x, cursor]
    move_down lineheight_y
    text_box @address.first_line, :at => [address_x, cursor]
    move_down lineheight_y
    if @address.second_line
      text_box @address.second_line, :at => [address_x, cursor]
      move_down lineheight_y
    end
    if @address.third_line
      text_box @address.third_line, :at => [address_x, cursor]
      move_down lineheight_y
    end
    text_box @address.city_and_postcode, :at => [address_x, cursor]

    move_cursor_to last_measured_y

    table(@invoice_header_data, :position => invoice_header_x, :width => 215) do
      style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
      style(row(2), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
      style(column(1), :align => :right)
      style(row(2).columns(0), :borders => [:top, :left, :bottom])
      style(row(2).columns(1), :borders => [:top, :right, :bottom])
    end

    move_down 45

    table(@invoice_services_data, :width => bounds.width) do
      style(row(1..-1).columns(0..-1), :padding => [4, 5, 4, 5], :borders => [:bottom], :border_color => 'dddddd')
      style(row(0), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
      style(row(0).columns(0..-1), :borders => [:top, :bottom])
      style(row(0).columns(0), :borders => [:top, :left, :bottom])
      style(row(0).columns(-1), :borders => [:top, :right, :bottom])
      style(row(-1), :border_width => 2)
      style(column(2..-1), :align => :right)
      style(columns(0), :width => 75)
      style(columns(1), :width => 275)
    end

    move_down 1

    table(@invoice_services_totals_data, :position => invoice_header_x, :width => 215) do
      style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
      style(row(0), :font_style => :bold)
      style(row(2), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
      style(column(1), :align => :right)
      style(row(2).columns(0), :borders => [:top, :left, :bottom])
      style(row(2).columns(1), :borders => [:top, :right, :bottom])
    end

    move_down 25

    table(@invoice_notes_data, :width => 275) do
      style(row(0..-1).columns(0..-1), :padding => [1, 0, 1, 0], :borders => [])
      style(row(0).columns(0), :font_style => :bold)
    end
  end
end
