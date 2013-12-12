class Journal < ActiveRecord::Base
  validates :journable_type, uniqueness: { scope: [:journable_id, :user_id], message: "Sorry, only one journal entry allowed." }

  belongs_to :user
  belongs_to :journable, polymorphic: true
end