require 'rails_helper'

RSpec.describe "customers/show", type: :view do
  before(:each) do
    assign(:customer, Customer.create!(
      full_name: "Full Name",
      phone_number: "Phone Number",
      address: "Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Full Name/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Address/)
  end
end
