# frozen_string_literal: true

RSpec.describe CoffeeRewardsJob, type: :job do
  context 'coffee rewards' do
    let!(:user) { create(:user, :india) }

    it 'should not provide Coffee reward for the customers having < 90 loyalty points and not birthday month' do
      user.update(loyalty_points: 90, date_of_birth: DateTime.now - 2.months)
      CoffeeRewardsJob.perform_now
      expect(user.rewards.first).to be nil
    end

    it 'should provide Coffee reward for the customers having birthday month' do
      user.update(loyalty_points: 0, date_of_birth: DateTime.now)
      CoffeeRewardsJob.perform_now
      expect(user.rewards.first.name).to eq 'Free Coffee_Reward'
    end

    it 'should provide Coffee reward for the customers having > 100 loyalty points' do
      user.update(loyalty_points: 100, date_of_birth: DateTime.now - 2.months)
      CoffeeRewardsJob.perform_now
      expect(user.rewards.first.name).to eq 'Free Coffee_Reward'
    end

    it 'should provide Coffee reward for the customers having > 100 loyalty points or birthday month' do
      user.update(loyalty_points: 110, date_of_birth: DateTime.now)
      CoffeeRewardsJob.perform_now
      expect(user.rewards.first.name).to eq 'Free Coffee_Reward'
    end
  end
end
