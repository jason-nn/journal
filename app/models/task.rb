class Task < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :details, presence: true
  validates :date, presence: true
  validates :user_id, presence: true
end
