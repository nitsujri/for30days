class Task < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user

  has_many :task_logs
  
  has_one :journal, :as => :journable

  #We are 1 indexed
  def day_count
    (self.start_date - Date.today.in_time_zone(self.user.time_zone).to_date).abs.round + 1
  end

  def has_conflicts?
    current_start_date = self.start_date


    Task.where(status: ['inactive', 'active']).where(user_id: self.user.id).where("id <> ?", self.id).each do |t|

      if current_start_date >= t.start_date and current_start_date < t.start_date + 30.days
        return true
      end
    end
    
    false
  end

  def marked_today?
    
    return true if todays_log.present?

    return false
    
  end

  def todays_log
    #get User's Time
    Time.use_zone self.user.time_zone do
      user_time = Time.zone.now
      mysql_tz_name = ActiveSupport::TimeZone[self.user.time_zone].tzinfo.name

      #Convert everything to user's local time, otherwise things get funky
      return self.task_logs.where(
                              "DATE(CONVERT_TZ(created_at, 'UTC', '#{mysql_tz_name}')) = ?",
                              user_time.to_date
                            ).first

    end

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
