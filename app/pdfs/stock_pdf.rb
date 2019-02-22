class StockPdf < Prawn::Document
  def initialize(attributes)
    super(optimize_objects: true, compress: true)
    cart_item = CartItem.joins(:cart, product: :product_group)
                        .merge(Cart.orders.month_of("January"))
    @products = Product.order(:id)
    @oil = [@products.select(&:oil?).map(&:oil_name).unshift("Product")]
    @capsules_and_balm = [@products.reject(&:oil?).map(&:specific_name).unshift("Product")]
    @hash = cart_item.group(:product_id).count
    @oil_count = product_count("oil")
    @capsules_and_balm_count = product_count("capsules")
    @oil_revenue = product_revenue("oil")
    @capsules_and_balm_revenue = product_revenue("capsules")
    @oil_total = product_total(@oil_revenue)
    @capsules_total = product_total(@capsules_and_balm_revenue)
    create
  end

  def product_total(var)
    var.first.drop(1).map{|i| i.tr("£", "").to_f}.reduce(:+).to_i
  end

  def oil?(str)
    str == "oil"
  end

  def id_range(str)
   oil?(str) ? (4..Product.count) : (1..3)
  end

  def product_count(str)
    id_range = id_range(str)
    [id_range.to_a.map { |id| @hash[id] || "0" }.unshift("Quantity")]
  end

  def product_revenue(str)
    id_range = id_range(str)
    [id_range.to_a.map do |id|
      @hash[id] ? "£#{@hash[id] * @products.find([id]).first.price}" : "£0"
    end.unshift("Price")]
  end

  def tables(str)
    table([["#{str}s"].map{|i| i.capitalize.tr("_", " ")}], position: :left) do
      style(row(0..-1).columns(0..-1), padding: [10,10,10,10], width: 160, borders: [], background_color: 'e9e9e9', border_color: 'dddddd', align: :center)
    end

    table(self.instance_variable_get(:"@#{string}"), width: bounds.width) do
      style(row(0..-1).columns(0), padding: [5,5,5, 5], align: :left)
      style(row(0..-1).columns(1..-1), borders: [], padding: [5,5,5,5], background_color: 'e9e9e9', border_color: 'dddddd', align: :center)
    end

    table(self.instance_variable_get(:"@#{string}_count"), width: bounds.width) do
      style(row(0..-1).columns(0), align: :left, padding: [5,5,5,0])
      style(row(0..-1).columns(1..-1),padding: [5,20,5, 20])
    end

     table(self.instance_variable_get(:"@#{string}_revenue"), width: bounds.width) do
      style(row(0..-1).columns(0), align: :left, padding: [5,5,5,5])
      style(row(0..-1).columns(1..-1), padding: [5,5,5,5])
    end

    table(self.instance_variable_get(:"@#{string}_total"), width: bounds.width) do
      style(row)
    end
  end

  def create
    initial_y = cursor
    initialmove_y = 5
    address_x = 35
    invoice_header_x = 325
    lineheight_y = 12
    font_size = 10

    move_down initialmove_y

    font_size font_size

    text_box "fourfive,", :at => [address_x,  cursor]
    move_down lineheight_y
    text_box "Flow Nutrition Ltd,", :at => [address_x,  cursor]
    move_down lineheight_y
    text_box "2 Victoria Square,", :at => [address_x,  cursor]
    move_down lineheight_y
    text_box "Victoria Street,", :at => [address_x,  cursor]
    move_down lineheight_y
    text_box "St. Albans, UK, AL1 3TF", :at => [address_x,  cursor]
    move_down lineheight_y

    last_measured_y = cursor
    move_cursor_to bounds.height + 12

    image open("http://res.cloudinary.com/dq2kcu9ey/image/asset/logo-abe391415fa40d83ff8e3aea6fe6945a.png"), :width => 120, :position => :right

    move_cursor_to last_measured_y

    move_down 85
    last_measured_y = cursor

    move_cursor_to last_measured_y

    tables("oil")

    move_down 40

    tables("capsules_and_balm")
    # table([["Capsules & Balms"]]) do
    #   style(row(0..-1).columns(0..-1), :borders => [], :background_color => 'e9e9e9', :border_color => 'dddddd')
    # end
    # table(@capsules_and_balm, :width => bounds.width) do
    #   # style(row(1..-1).columns(0..-1), :padding => [4, 5, 4, 5], :borders => [:bottom], :border_color => 'dddddd')
    #   # style(row(0), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
    #   # style(row(0).columns(0..-1), :borders => [:top, :bottom])
    #   # style(row(0).columns(0), :borders => [:top, :left, :bottom])
    #   # style(row(0).columns(-1), :borders => [:top, :right, :bottom])
    #   # style(row(-1), :border_width => 2)
    #   # style(column(2  ..-1), :align => :right)
    #   # style(columns(0), :width => 75)
    #   # style(columns(1), :width => 275)
    #   style(row(0..-1).columns(0..-1), :borders => [], :background_color => 'e9e9e9', :border_color => 'dddddd')
    #   # style(row(0).columns(0), :font_style => :bold)
    # end

    # table(@rest_count, width: bounds.width) do
    #   style(row(0..-1).columns(0..-1), borders: [])
    # end

    #  table(@rest_revenue, width: bounds.width) do
    #   style(row(0..-1).columns(0..-1), borders: [])
    # end

  end
end







