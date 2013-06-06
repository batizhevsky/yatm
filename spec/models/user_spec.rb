require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create :user }

  it "be online after create" do
    user.should be_online
  end
end
