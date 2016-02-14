require 'spec_helper'

describe "Relationship" do
  before do
    @relationship = Relationship.new(follower_id: 1, followed_id: 2)
  end

  it "should be valid" do
    expect(@relationship.valid?).to eq(true)
  end

  it "should require a follower_id" do
    @relationship.follower_id = nil
    expect(@relationship.valid?).to eq(false)
  end

  it "should require a followed_id" do
    @relationship.followed_id = nil
    expect(@relationship.valid?).to eq(false)
  end

end
