require_relative './document.rb'
class InvoicePdf < Prawn::Document
  def initialize(attributes)
    super(optimize_objects: true, compress: true)
    @address = attributes[:address]
    @amount = attributes[:amount]
    @date = attributes[:date]
    @cart_items = attributes[:cart_items]
    @coupon = attributes[:coupon]
    @order_id = attributes[:order_id]
    invoice_data
    create
  end

  private

  def create
    initial_y = cursor
    initialmove_y = 5
    @address_x = 35
    @invoice_header_x = 325
    @lineheight_y = 12
    font_size = 10

    move_down initialmove_y

    font_size font_size

    many_box(["fourfive", "Flow Nutrition Ltd,", "2 Victoria Square,", "Victoria Street,", "St. Albans, UK, AL1 3TF"])

    last_measured_y = cursor
    move_cursor_to bounds.height + 12

    image open("http://res.cloudinary.com/dq2kcu9ey/image/asset/logo-abe391415fa40d83ff8e3aea6fe6945a.png"), width: 120, position: :right

    move_cursor_to last_measured_y

    move_down 65
    last_measured_y = cursor

    array = [@address.full_name_with_salutation,
             @address.first_line,
             @address.second_line,
             @address.third_line,
             @address.city_and_postcode,
             @address.phone_number]

    move_down 20
    many_box(array.compact.reject(&:empty?))

    move_cursor_to last_measured_y
    move_down 20

    tables

    require 'prawn/icon'
    # move_right 150
    bounding_box([40, 250], width: 300) do
      icon @icons, inline_format: true
    end
  end

  def tables
    table(@invoice_header_data, position: @invoice_header_x, width: 200) do
      style(row(0..1).columns(0..1), padding: [1, 5, 1, 5], borders: [])
      style(column(1), align: :right)
    end

    move_down 75

    table(@invoice_services_data, width: 490, position: @address_x) do
      style(row(1..-1).columns(0..-1), padding: [4, 5, 4, 5], borders: [:bottom], border_color: 'dddddd')
      style(row(0), background_color: 'e9e9e9', border_color: 'dddddd', font_style: :bold)
      style(row(0).columns(0..-1), borders: [:top, :bottom])
      style(row(0).columns(0), borders: [:top, :left, :bottom])
      style(row(0).columns(-1), borders: [:top, :right, :bottom])
      style(row(-1), border_width: 2)
      style(column(2..-1), align: :right)
      style(columns(0), width: 75)
      style(columns(1), width: 240)
    end

    move_down 1

    table(@invoice_services_totals_data, position: @invoice_header_x - 15, width: 215) do
      style(row(0..2).columns(0..1), padding: [1, 5, 1, 5], borders: [])
      style(row(0), font_style: :bold)
      style(row(3), background_color: 'e9e9e9', border_color: 'dddddd', font_style: :bold)
      style(column(1), align: :right)
      style(row(3).columns(0), borders: [:top, :left, :bottom])
      style(row(3).columns(1), borders: [:top, :right, :bottom])
    end

    move_down 25

    table(@invoice_notes_data, width: 275, position: @address_x) do
      style(row(0..-1).columns(0..-1), padding: [10, 0, 10, 0], borders: [])
      style(row(0).columns(0), font_style: :bold)
    end

    move_down 10
  end

  def invoice_data
    @invoice_services_data = [["Item", "Description", "Unit Cost", "Quantity", "Line Total"]]
    @cart_items.each do |item|
      product = item.product
      @invoice_services_data << [product.readable_name,
                                 product.specific_name,
                                 product.price,
                                 item.quantity,
                                 item.line_cost].map(&:to_s)
    end
    #COUPONS
    @invoice_notes_data = [["Notes"], ["Thank you for doing business with fourfive,"], ["George & Dom"]]
    @invoice_services_totals_data = [
      ["Total", "£#{@amount}"],
      ["Amount Paid", "£#{@amount}"],
      ["Amount Due", "£0.00 GBP"]
    ]
    if @coupon
      @invoice_services_totals_data.insert(1, ["Coupon", @coupon.discount.to_s + "%"])
    end
    date = Date.today.strftime('%A, %b %d')
    @invoice_header_data = [["Receipt #", @order_id.to_s], ["Receipt Date", date]]
    @icons = icon_map(["facebook", "twitter", "instagram"])
  end

  def icon_map(brands)
    brands.map! do |brand|
      "<link href='http://www.#{brand}.com/fourfivecbd' target='_blank'><icon size='20' color='AAAAAA'>fab-#{brand}</icon></link>"
    end
    brands.join("    ")
  end
end
