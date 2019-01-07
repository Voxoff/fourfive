require "rails_helper"

RSpec.feature "Visit all pages", :type => :feature do
  before(:all) do
    Rails.application.load_seed
  end
  scenario "Visit home" do
    visit "/"
    expect(page).to have_text("fourfive")
  end

  scenario "Visit oils" do
    visit "/products/cbd_oils"
    expect(page).to have_text("fourfive")
  end

  scenario "Visit balms" do
    visit "/products/cbd_balms"
    expect(page).to have_text("fourfive")
  end

  scenario "Visit capsules" do
    visit "/products/cbd_capsules"
    expect(page).to have_text("fourfive")
  end

  scenario "Visit education" do
    visit "/education"
    expect(page).to have_text("fourfive")
  end

  scenario "Visit about" do
    visit "/about"
    expect(page).to have_text("fourfive")
  end
end
