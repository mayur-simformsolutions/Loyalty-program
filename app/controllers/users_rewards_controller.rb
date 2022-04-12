# frozen_string_literal: true

class UsersRewardsController < ApplicationController
  def index
    @rewards = current_user.rewards
  end
end
