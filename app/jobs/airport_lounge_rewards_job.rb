# frozen_string_literal: true

class AirportLoungeRewardsJob < ApplicationJob
  queue_as :default

  def perform
    users = User.where('loyalty_points > 1000').select("users.id as user_id, #{reward_id} as reward_id").as_json
    UserReward.create(users)
  end

  def reward_id
    @reward_id ||= Reward.find_or_create_by(name: 'Airport Lounge Access Reward').id
  end
end
