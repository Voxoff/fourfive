ActiveAdmin.register_page "Stock Table" do
  page_action :print do
    pdf = StockPdf.new({})
    send_data pdf.render, filename: "receipt.pdf"
  end

  action_item :print do
    link_to "Add Event", admin_stock_table_print_path
  end

  content do
    panel "Stock Sold" do
      render 'admin/stock_table'
    end
    panel "Download" do
      div do
        link_to "Print", admin_stock_table_print_path, target: "_blank"
      end
    end
  end
end
