class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates :name, length: { minimum: 5 }
  validates :password, length: { minimum: 3 }
  has_many :tasks, dependent: :destroy
end
