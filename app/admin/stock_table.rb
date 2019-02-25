ActiveAdmin.register_page "Stock" do
  page_action :print do
    pdf = StockPdf.new(month: params[:month])
    send_data pdf.render, filename: "receipt.pdf"
  end

  # action_item :print do
  #   link_to "Add Event", admin_stock_table_print_path
  # end

  content do
    panel "Stock Sold" do
      render 'admin/stock_table'
    end
    panel "Download" do
      dates = (Date.parse("1st January 2019")..Date.today).map{|i| i.strftime("%B %Y")}.uniq
      dates.each do |month|
        div do
          link_to "Print " + month + " revenue", admin_stock_print_path(month: month), target: "_blank"
        end
      end
    end
  end
end
