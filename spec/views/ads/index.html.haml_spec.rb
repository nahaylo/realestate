require 'spec_helper'

describe "ads/index.html.haml" do
  before(:each) do
    assign(:ads, [
      stub_model(Ad,
        :ad => "Ad",
        :phone => "Phone",
        :price => "9.99",
        :price_type => 1
      ),
      stub_model(Ad,
        :ad => "Ad",
        :phone => "Phone",
        :price => "9.99",
        :price_type => 1
      )
    ])
  end

  it "renders a list of ads" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ad".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
