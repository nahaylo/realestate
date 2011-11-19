require 'spec_helper'

describe "ads/show.html.haml" do
  before(:each) do
    @ad = assign(:ad, stub_model(Ad,
      :ad => "Ad",
      :phone => "Phone",
      :price => "9.99",
      :price_type => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ad/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Phone/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
