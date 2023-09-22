require 'rails_helper'

RSpec.describe "customers/new", type: :view do
  before(:each) do
    assign(:customer, Customer.new(
      full_name: "MyString",
      phone_number: "MyString",
      address: "MyString"
    ))
  end

  it "renders new customer form" do
    render

    assert_select "form[action=?][method=?]", customers_path, "post" do

      assert_select "input[name=?]", "customer[full_name]"

      assert_select "input[name=?]", "customer[phone_number]"

      assert_select "input[name=?]", "customer[address]"
    end
  end
end
