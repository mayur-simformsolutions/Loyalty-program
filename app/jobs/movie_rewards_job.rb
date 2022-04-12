# frozen_string_literal: true

class MovieRewardsJob < ApplicationJob
  queue_as :default

  def perform
    users = User.joins(:transactions).where('users.created_at > ?',
                                            DateTime.now - 2.months).group('users.id').select("MIN(transactions.created_at) as created_at, users.id as user_id, #{reward_id} as reward_id").where('transactions.amount > 10').as_json
    updated_users = remove_created_at(users)
    UserReward.first_or_create(updated_users)
  end

  def remove_created_at(users)
    users.each { |user| user.delete('created_at') }
  end

  def reward_id
    @reward_id ||= Reward.find_or_create_by(name: 'Free Movie ticket').id
  end
end
