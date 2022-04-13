# frozen_string_literal: true

class ExpiringLoyaltyPointsJob < ApplicationJob
  queue_as :default

  def perform
    User.where('created_at < ?', DateTime.now - 1.year).update_all(loyalty_points: 0)
  end
end
