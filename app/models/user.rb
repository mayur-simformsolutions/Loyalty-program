# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions, dependent: :destroy
  has_many :user_rewards, dependent: :destroy
  has_many :rewards, through: :user_rewards

  DEFAULT_COUNTRY = 'India'

  def loyalty_tier
    case self.loyalty_points
      when 0...1000
        "Standard"
      when 1000...5000
        "Gold"
      else
        "Platinum"
    end
  end
end
