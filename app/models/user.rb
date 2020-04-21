class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: true
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, foreign_key: :user_id, dependent: :destroy
  has_many :messages, foreign_key: :user_id, dependent: :destroy
end
