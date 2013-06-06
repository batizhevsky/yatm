require 'spec_helper'

describe UserDecorator do
  let(:user) { FactoryGirl.create(:user) }

  it "show name if exist" do
    user.update_attributes(name: "test")
    decorated = user.decorate
    decorated.show_name.should eq user.name
  end

  it "show email if name not exist" do
    user.update_attributes(name: nil)
    decorated = user.decorate
    decorated.show_name.should eq user.email
  end
end
