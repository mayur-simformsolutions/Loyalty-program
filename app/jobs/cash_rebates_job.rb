# frozen_string_literal: true

class CashRebatesJob < ApplicationJob
  queue_as :default

  def perform
    users = User.joins(:transactions).group(:id).having('count(transactions.amount > 100) > 10').select("users.id as user_id, #{reward_id} as reward_id").as_json
    UserReward.create(users)  
  end

  def reward_id
    @reward_id ||= Reward.find_or_create_by(name: '5% Cash Rebate').id
  end
end
