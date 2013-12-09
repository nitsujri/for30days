class Task < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user

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
