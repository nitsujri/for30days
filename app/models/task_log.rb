class TaskLog < ActiveRecord::Base

  belongs_to :task

  has_one :journal, :as => :journable
end
