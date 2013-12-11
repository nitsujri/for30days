require 'spec_helper'

describe Task do
  it "Fails no name" do
    expect {  Task.create!(start_date: Date.today) }.to raise_error
  end

  describe "Conflict check" do
    before :each do
      @user = create(:user)
      @task = create(:task)
    end

    it "Has a Conflict" do
      r = Task.new(name: "test", user_id: @user.id).has_conflicts?

      r.should be(true)
    end

    it "Beyond 31 days - No Conflict" do
      r = Task.new(
          name: "test", 
          user_id: @user.id,
          start_date: Date.today + 31.day
        ).has_conflicts?

      r.should be(false)
    end
  end

  describe "Daily Mark" do
    before :each do
      @user = create(:user)
      @task = create(:task)
      @tasklog = create(:task_log)
    end

    it "should should be marked" do
      @task.marked_today?.should eq(true)
    end

    it "time passed - not marked yet" do
      Timecop.freeze(Time.now + 1.day) do
        @task.marked_today?.should eq(false) 
      end
    end
  end
end
