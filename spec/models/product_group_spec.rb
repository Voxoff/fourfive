require 'rails_helper'

RSpec.describe ProductGroup, type: :model do
  context "Groups" do
    balm_product_group = FactoryBot.create(:balm_product_group)
    oil_product_group = FactoryBot.create(:oil_product_group)
    capsule_product_group = FactoryBot.create(:capsule_product_group)

    describe "#readable_name?" do
      it "gets rid of underscore" do
        expect(balm_product_group.readable_name).to eq "cbd balms"
        expect(oil_product_group.readable_name).to eq "cbd oils"
      end
    end

    describe "#group_name?" do
      it "returns group name" do
        expect(balm_product_group.group_name).to eq "balms"
        expect(oil_product_group.group_name).to eq "oils"
        expect(capsule_product_group.group_name).to eq "capsules"
      end
    end
  end
end
