# frozen_string_literal: true

class UpdateLoyaltyPointsJob < ApplicationJob
  queue_as :default

  def perform(user_id, transaction_id)
    user(user_id).update(loyalty_points: loyalty_points(user(user_id), transaction_amount(transaction_id)))
  end

  def loyalty_points(user, transaction_amount)
    (transaction_amount / 100 * (user.country == User::DEFAULT_COUNTRY ? 10 : 20)) + user.loyalty_points
  end

  def user(id)
    @user ||= User.find(id)
  end

  def transaction_amount(id)
    @transaction_amount ||= Transaction.find(id).amount
  end
end
