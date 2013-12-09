require 'spec_helper'

describe Task do
  it "Fails no name" do
    expect {  Task.create!(start_date: Date.today) }.to raise_error
  end

  it "Has a Conflict" do
    user = create(:user)
    task = create(:task)

    r = Task.new(name: "test", start_date: Date.today + 1.day).has_conflicts?(user)

    r.should == true
  end
end
