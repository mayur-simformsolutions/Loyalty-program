# frozen_string_literal: true

class AirportLoungeRewardsJob < ApplicationJob
  queue_as :default

  # Perform job to assign Airport Lounge Access Reward for specific users
  def perform
    users = User.where('loyalty_points >= 1000').select("users.id as user_id, #{reward_id} as reward_id").as_json
    UserReward.first_or_create(users)
  end

  # Used to find the specific reward
  def reward_id
    @reward_id ||= Reward.find_or_create_by(name: 'Airport Lounge Access Reward').id
  end
end
