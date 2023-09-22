require 'rails_helper'

RSpec.describe "customers/edit", type: :view do
  let(:customer) {
    Customer.create!(
      full_name: "MyString",
      phone_number: "MyString",
      address: "MyString"
    )
  }

  before(:each) do
    assign(:customer, customer)
  end

  it "renders the edit customer form" do
    render

    assert_select "form[action=?][method=?]", customer_path(customer), "post" do

      assert_select "input[name=?]", "customer[full_name]"

      assert_select "input[name=?]", "customer[phone_number]"

      assert_select "input[name=?]", "customer[address]"
    end
  end
end
