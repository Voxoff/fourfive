class StockPdf < Prawn::Document
  def initialize(attributes)
    super(optimize_objects: true, compress: true)
    cart_item = CartItem.joins(:cart, product: :product_group)
                        .merge(Cart.orders.month_of("January"))
    @products = Product.order(:id)
    @oil = [@products.select(&:oil?).map(&:oil_name).unshift("Product")]
    @capsule_and_balm = [@products.reject(&:oil?).map(&:specific_name).unshift("Product")]
    @hash = cart_item.group(:product_id).count
    @oil_count = product_count("oil")
    @capsule_and_balm_count = product_count("capsule_and_balm")
    @oil_revenue = product_revenue("oil")
    @capsule_and_balm_revenue = product_revenue("capsule_and_balm")
    @oil_total = [product_total(@oil_revenue)]
    @capsule_and_balm_total = [product_total(@capsule_and_balm_revenue)]
    create
  end

  def product_total(var)
    ["Total", "£" + var.first.drop(1).map{ |i| i.tr("£", "").to_f}.reduce(:+).to_i.to_s ]
  end

  def oil?(str)
    str == "oil"
  end

  def id_range(str)
   oil?(str) ? (4..Product.count) : (1..3)
  end

  def product_count(str)
    id_range = id_range(str)
    count = id_range.to_a.map { |id| @hash[id] || "0" }
    [count.unshift("Quantity")]
  end

  def product_revenue(str)
    id_range = id_range(str)
    revenue = id_range.to_a.map do |id|
      @hash[id] ? "£#{@hash[id] * @products.find([id]).first.price}" : "£0"
    end
    [revenue.unshift("Revenue")]
  end

  def tables(str)
    table([["#{str}s"].map{|i| i.capitalize.tr("_", " ")}], position: :left) do
      style(row(0..-1).columns(0..-1), padding: [10,10,3,10], width: 160, borders: [], background_color: 'e9e9e9', border_color: 'dddddd', align: :center)
    end

    table(self.instance_variable_get(:"@#{str}"), width: bounds.width) do
      style(row(0..-1).columns(0), padding: [5,5,5, 5], align: :left, borders: [], background_color: 'e9e9e9', border_color: 'dddddd')
      style(row(0..-1).columns(1..-1), borders: [], padding: [5,5,5,5], background_color: 'e9e9e9', border_color: 'dddddd', align: :center)
    end

    table(self.instance_variable_get(:"@#{str}_count"), width: bounds.width) do
      style(row(0..-1).columns(0), align: :left, padding: [5,0,5,5], borders: [])
      if str == "oil"
        style(row(0..-1).columns(1), align: :center, padding: [5,20,5, 0], borders: [])
        style(row(0..-1).columns(2..-1), align: :center, padding: [5,20,5, 20], borders: [])
      else
        style(row(0..-1).columns(1..-1), align: :center, padding: [5,20,5, 20], borders: [])
      end
    end

     table(self.instance_variable_get(:"@#{str}_revenue"), width: bounds.width) do
      style(row(0..-1).columns(0), align: :left, padding: [5,5,5,5], borders: [])
      if str == "oil"
        style(row(0..-1).columns(1), align: :left,padding: [5,0,5,10], borders: [:top], border_width: 1, border_color: 'e9e9e9')
        style(row(0..-1).columns(2..-1), align: :center,padding: [5,5,5,5], borders: [:top], border_width: 1, border_color: 'e9e9e9')
      else
        style(row(0..-1).columns(1..-1), align: :center,padding: [5,5,5,5], borders: [:top], border_width: 1, border_color: 'e9e9e9')
      end
    end

    table(self.instance_variable_get(:"@#{str}_total"), width: bounds.width) do
      style(row(0..1).columns(0), align: :left, borders: [:top], border_width: 1, border_color: 'e9e9e9', padding: [5, 5, 5, 5])
      style(row(0..1).columns(1), align: :right, borders: [:top], border_width: 1, border_color: 'e9e9e9', padding: [5, str == "oil" ? 20 : 50, 5, 0])
    end
  end

  def create
    initial_y = cursor
    initialmove_y = 5
    address_x = 15
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

    tables("capsule_and_balm")
    # table([["Capsules & Balms"]]) do
    #   style(row(0..-1).columns(0..-1), :borders => [], :background_color => 'e9e9e9', :border_color => 'dddddd')
    # end
    # table(@capsule_and_balm, :width => bounds.width) do
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







