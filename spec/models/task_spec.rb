require 'spec_helper'

describe Task do
  it "Fails no name" do
    expect {  Task.create!(start_date: Date.today) }.to raise_error
  end

  describe "Task Conflicts" do
    before :each do
      @user = create(:user)
      @task = create(:task)
    end

    it "Has a Conflict" do
      r = Task.new(name: "test", start_date: Date.today + 1.day).has_conflicts?(@user)

      r.should == true
    end

    it "Beyond 31 days - No Conflict" do
      r = Task.new(name: "test", start_date: Date.today + 31.day).has_conflicts?(@user)

      r.should == false
    end
  end
end
