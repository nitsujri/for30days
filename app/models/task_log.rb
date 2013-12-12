class TaskLog < ActiveRecord::Base

  belongs_to :task

  has_many :journals, :as => :journable
end
