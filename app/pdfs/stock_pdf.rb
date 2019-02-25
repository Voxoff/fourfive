require_relative './document.rb'
class StockPdf < Prawn::Document
  def initialize(attributes)
    super(optimize_objects: true, compress: true)
    @month = attributes[:month]
    @hash = CartItem.joins(:cart, product: :product_group)
                    .merge(Cart.orders.month_of(attributes[:month]))
                    .group(:product_id)
                    .count
    @products = Product.order(:id)
    table_data
    create
  end

  def table_data
    @oil = [@products.select(&:oil?).map(&:oil_name).unshift("Product")]
    @capsule_and_balm = [@products.reject(&:oil?).map(&:specific_name).unshift("Product")]
    @oil_count = product_count("oil")
    @capsule_and_balm_count = product_count("capsule_and_balm")
    oil_prod_revenue_data = revenue_data("oil")
    capsule_and_balm_revenue_data = revenue_data("capsule_and_balm")
    @oil_revenue = printable_revenue(oil_prod_revenue_data)
    @capsule_and_balm_revenue = printable_revenue(capsule_and_balm_revenue_data)
    @oil_total = product_total(oil_prod_revenue_data)
    @capsule_and_balm_total = product_total(capsule_and_balm_revenue_data)
  end

  def product_total(rev_data)
    total = ActionController::Base.helpers.humanized_money_with_symbol(rev_data.reduce(:+))
    [Array(total).unshift("Total")]
  end

  def oil?(str)
    str == "oil"
  end

  def id_range(str)
    oil?(str) ? (4..Product.count).to_a : (1..3).to_a
  end

  def product_count(str)
    count = id_range(str).map { |id| @hash[id] || "0" }
    [count.unshift("Quantity")]
  end

  def revenue_data(str)
    id_range(str).map { |id| Product.find(id).revenue(@hash[id]) }
  end

  def printable_revenue(prod_rev)
    revenue = prod_rev.map{|i| ActionController::Base.helpers.humanized_money_with_symbol(i) }
    [revenue.unshift("Revenue")]
  end

  def tables(str)
    header_borders = {border_width: 1, border_color: 'dddddd', background_color: 'e9e9e9'}
    summary_borders = {borders: [:top], border_width: 1, border_color: 'e9e9e9'}

    table([["#{str}s"].map{|i| i.capitalize.tr("_", " ")}], position: :left) do
      cells.style(header_borders)
      style(row(0..-1).columns(0..-1), padding: [7, 10, 3, 10], width: 160, borders: [:bottom], align: :center)
    end

    table(self.instance_variable_get(:"@#{str}"), width: bounds.width) do
      cells.borders = [:top]
      cells.padding = [5,5,5,5]
      cells.style(header_borders)
      style(row(0..-1).columns(0), align: :left)
      style(row(0..-1).columns(1..-1), align: :center)
    end

    table(self.instance_variable_get(:"@#{str}_count"), width: bounds.width) do
      cells.borders = []
      style(row(0..-1).columns(0), align: :left, padding: [5, 0, 5, 5])
      if str == "oil"
        style(row(0..-1).columns(1), align: :center, padding: [5, 20, 5, 0])
        style(row(0..-1).columns(2..-1), align: :center, padding: [5, 20, 5, 20])
      else
        style(row(0..-1).columns(1..-1), align: :center, padding: [5, 20, 5, 20])
      end
    end

    table(self.instance_variable_get(:"@#{str}_revenue"), width: bounds.width) do
      cells.style(summary_borders)
      cells.padding = [5,15,5,5]
      style(row(0..-1).columns(0), align: :left, borders: [])
      if str == "oil"
        style(row(0..-1).columns(1), align: :left,padding: [5, 0, 5, 0])
        style(row(0..-1).columns(2..-1), align: :center)
      else
        style(row(0..-1).columns(1..-1), align: :center)
      end
    end

    table(self.instance_variable_get(:"@#{str}_total"), width: bounds.width) do
      cells.borders = [:top]
      cells.border_width = 1
      cells.border_color = 'e9e9e9'
      style(row(0..1).columns(0), align: :left, padding: [5, 5, 5, 5])
      style(row(0..1).columns(1), align: :right, padding: [5, str  == "oil" ? 20 : 50, 5, 0])
    end
  end

  def create
    initial_y = cursor
    initialmove_y = 5
    @address_x = 15
    month_header = 235
    @lineheight_y = 12
    font_size = 10

    move_down initialmove_y

    font_size font_size

    many_box(["fourfive", "Flow Nutrition Ltd,", "2 Victoria Square,", "Victoria Street,", "St. Albans, UK, AL1 3TF"])

    last_measured_y = cursor
    move_cursor_to bounds.height + 12

    image open("http://res.cloudinary.com/dq2kcu9ey/image/asset/logo-abe391415fa40d83ff8e3aea6fe6945a.png"), :width => 120, :position => :right

    move_cursor_to last_measured_y

    move_down 50
    font_size 15
    text_box @month, :at => [month_header, cursor]
    font_size font_size

    move_down 85
    last_measured_y = cursor

    move_cursor_to last_measured_y

    tables("oil")

    move_down 40

    tables("capsule_and_balm")
  end
end
