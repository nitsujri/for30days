class Task < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user

  def has_conflicts?(user)
    current_start_date = self.start_date

    Task.where(status: ['inactive', 'active']).where(user_id: user.id).each do |t|
      if current_start_date > t.start_date and current_start_date <= t.start_date + 30.days
        return true
      end
    end
    
    false
  end

  class << self
    #display_name
    def display_name
      "Goal"
    end

    def display_name_s
      display_name + "s"
    end

    def display_name_long
      "30 Day #{display_name}"
    end

    def display_name_s_long
      display_name_long + "s"
    end
  end
end
