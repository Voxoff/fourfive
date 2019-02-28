require 'rails_helper'
require "#{Rails.root}/app/pdfs/prawn_warning.rb"

RSpec.describe 'invoice_pdf' do
  context "Set up" do
    before do
      cart = FactoryBot.create(:cart)
      view_context = ActionController::Base.new.view_context
      pdf = InvoicePdf.new(cart)
      rendered_pdf = pdf.render
      @text_analysis = PDF::Inspector::Text.analyze(rendered_pdf)
    end

    describe "requirements" do
      it "has a cart" do
        expect(cart).to be_valid
        expect(cart).to be_an_instance_of(Cart)
      end

      it "cart must have an address" do
        expect(cart.address).to be_an_instance_of(Address)
      end

      it "cart must have one or more cart items" do
        expect(cart.cart_items.size).to be >= 1
      end

      it "may have an order_id" do
        expect(cart.order_id).to be 1
      end
    end
  end

  context "Part pdf" do
    describe "non-db stuff" do
      it 'has an address' do
        expect(@text_analysis.strings).to include("fourfive")
        expect(@text_analysis.strings).to include("Flow Nutrition Ltd,")
        expect(@text_analysis.strings).to include("2 Victoria Square,")
        expect(@text_analysis.strings).to include("Victoria Street,")
        expect(@text_analysis.strings).to include("St. Albans, UK, AL1 3TF")
      end

      it "has a footer" do
        expect(@text_analysis.strings).to include("Notes")
        expect(@text_analysis.strings).to include("Thank you for doing business with fourfive,")
        expect(@text_analysis.strings).to include("George & Dom")
      end
    end
  end
end
