class Task < ApplicationRecord
  belongs_to :member
  enum priority: [:Baixa, :Media, :Alta]
  validates :name, :priority, :completed, presence: true
  validates :name, length: { minimum: 5, maximum: 50 }
  validates :description, length: { maximum: 140}
end
