require 'spec_helper'
require "#{Rails.root}/app/pdfs/prawn_warning.rb"

RSpec.describe 'stock_pdf' do
  context "Part of pdf" do
    before do
      FactoryBot.create(:oil_product)
      FactoryBot.create(:balm_product)
      FactoryBot.create(:capsule_product)
      view_context = ActionController::Base.new.view_context
      pdf = StockPdf.new(month: "January")
      rendered_pdf = pdf.render
      @text_analysis = PDF::Inspector::Text.analyze(rendered_pdf)
    end

    describe "address" do
      it "should include full text of address" do
        expect(@text_analysis.strings).to include("fourfive")
        expect(@text_analysis.strings).to include("Flow Nutrition Ltd,")
        expect(@text_analysis.strings).to include("2 Victoria Square,")
        expect(@text_analysis.strings).to include("Victoria Street,")
        expect(@text_analysis.strings).to include("St. Albans, UK, AL1 3TF")
      end
    end

    describe "month" do
      it "should include month" do
        expect(@text_analysis.strings).to include("January")
      end
    end

    describe "boxes" do
      it "should include table headers" do
        expect(@text_analysis.strings).to include("Oils")
        expect(@text_analysis.strings).to include("Product")
        expect(@text_analysis.strings).to include("Quantity")
        expect(@text_analysis.strings).to include("Revenue")
        expect(@text_analysis.strings).to include("Total")
      end
    end

    describe "oil box" do
      it "should include product names" do
        expect(@text_analysis.strings).to include("Natural 500mg")
      end
    end

    describe "capsules and balm box" do
      it "should include product names" do
        expect(@text_analysis.strings).to include("Small balm")
        expect(@text_analysis.strings.join("")).to include("Capsules")
      end
    end

    describe "Oil Quantity calculations" do
      it "should correctly calcuate quantity of cart items" do
        # TODO
      end
    end
  end

  context "Full database" do
    before do
      FactoryBot.create :oil_product
      FactoryBot.create :oil_product, :regular
      FactoryBot.create :oil_product, :strong
      FactoryBot.create :oil_product, :orange, :small
      FactoryBot.create :oil_product, :orange, :regular
      FactoryBot.create :oil_product, :orange, :strong
      FactoryBot.create :balm_product
      FactoryBot.create :balm_product, :large
      view_context = ActionController::Base.new.view_context
      pdf = StockPdf.new(month: "January")
      rendered_pdf = pdf.render
      @text_analysis = PDF::Inspector::Text.analyze(rendered_pdf)
    end

    describe "oil box" do
      it "should include product names" do
        expect(@text_analysis.strings).to include("Natural 500mg")
        expect(@text_analysis.strings).to include("Natural 1000mg")
        expect(@text_analysis.strings).to include("Natural 2000mg")
        expect(@text_analysis.strings).to include("Orange 2000mg")
        expect(@text_analysis.strings).to include("Orange 500mg")
        expect(@text_analysis.strings).to include("Orange 1000mg")
      end
    end

    describe "capsules and balm box" do
      it "should include product names" do
        expect(@text_analysis.strings.join("")).to include("Capsules")
        expect(@text_analysis.strings).to include("Small balm")
        expect(@text_analysis.strings).to include("Large balm")
      end
    end
  end
end
