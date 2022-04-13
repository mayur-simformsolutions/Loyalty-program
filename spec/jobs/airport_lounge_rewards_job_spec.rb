# frozen_string_literal: true

RSpec.describe AirportLoungeRewardsJob, type: :job do
  context 'airport lounge reward' do
    let!(:user) {create(:user, :india)}
    it 'should not provide AirportLoungeRewards for the customers having less than 1000 loyalty points' do
      user.update(loyalty_points: 100)
      AirportLoungeRewardsJob.perform_now
      expect(user.rewards.first).to be nil
    end

    it 'should provide AirportLoungeRewards for the customers having greater than 1000 loyalty points' do
      user.update(loyalty_points: 1000)
      AirportLoungeRewardsJob.perform_now
      expect(user.rewards.first.name).to eq "Airport Lounge Access Reward"
    end

    it 'should not provide AirportLoungeRewards for the customers having 0 loyalty points' do
      user.update(loyalty_points: 0)
      AirportLoungeRewardsJob.perform_now
      expect(user.rewards.first).to be nil
    end
  end
end
