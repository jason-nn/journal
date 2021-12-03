class Task < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :details, presence: true
  validates :date, presence: true
end
