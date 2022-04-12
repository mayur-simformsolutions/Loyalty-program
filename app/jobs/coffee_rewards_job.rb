# frozen_string_literal: true

class CoffeeRewardsJob < ApplicationJob
  queue_as :default

  def perform
    users = User.where('loyalty_points > ? or extract(month from created_at) = ?', 100,
                       DateTime.now.month).select("id as user_id, #{reward_id} as reward_id").as_json
    UserReward.first_or_create(users)
  end

  def reward_id
    @reward_id ||= Reward.find_or_create_by(name: 'Free Coffee_Reward').id
  end
end
