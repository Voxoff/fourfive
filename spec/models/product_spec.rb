require 'rails_helper'

RSpec.describe Product, type: :model do
  context "A User (in general)" do
    subject { Product.new(name: "x") }
    describe "Getter/setter methods" do
      it "should have name" do

        expect(subject.name).to eq 'x'
      end
    end
    describe "changes name" do
      subject { Product.new(name: "cbd_oils") }
      # subject { Product.new(name: "cbd_balms") }
      # subject { Product.new(name: "cbd_capsules") }
      it 'gets name' do
        expect(subjects.readable_name).to eq "cbd oils"
      end
    end
  end



end
