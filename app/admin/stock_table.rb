ActiveAdmin.register_page "Stock" do
  page_action :print do
    pdf = StockPdf.new(month: params[:month])
    send_data pdf.render, filename: "receipt.pdf"
  end

  content do
    panel "Stock Sold" do
      render 'admin/stock_table'
    end
    panel "Download" do
      dates = (Date.parse("1st January 2019")..Date.today).map{|i| i.strftime("%B %Y")}.uniq
      dates.each do |month_and_year|
        month = month_and_year.split(" ").first
        div do
          link_to "Print " + month_and_year + " revenue", admin_stock_print_path(month: month), target: "_blank"
        end
      end
      div do
        #is this hacky params?
        link_to "Print all", admin_stock_print_path(month: "TOTAL")
      end
    end
  end
end
