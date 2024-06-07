class Task < ApplicationRecord
  before_validation :check_completed 
  belongs_to :member
  enum priority: [:Baixa, :Media, :Alta]
  validates :name, :priority, presence: true
  validates :name, length: { minimum: 5, maximum: 50 }
  validates :description, length: { maximum: 140}
  validates :completed, inclusion: [true, false]

  private
  
  def check_completed
    #debugger
    self.due_date = Time.now if self.completed.present?
  end
end
