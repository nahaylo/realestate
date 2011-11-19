require 'spec_helper'

describe "ads/edit.html.haml" do
  before(:each) do
    @ad = assign(:ad, stub_model(Ad,
      :ad => "MyString",
      :phone => "MyString",
      :price => "9.99",
      :price_type => 1
    ))
  end

  it "renders the edit ad form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ads_path(@ad), :method => "post" do
      assert_select "input#ad_ad", :name => "ad[ad]"
      assert_select "input#ad_phone", :name => "ad[phone]"
      assert_select "input#ad_price", :name => "ad[price]"
      assert_select "input#ad_price_type", :name => "ad[price_type]"
    end
  end
end
