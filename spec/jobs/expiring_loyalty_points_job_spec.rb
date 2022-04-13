# frozen_string_literal: true

RSpec.describe ExpiringLoyaltyPointsJob, type: :job do
  context 'coffee rewards' do
    let!(:user) { create(:user, :india) }

    it 'should not provide Coffee reward for the customers having < 90 loyalty points and not birthday month' do
      user.update(loyalty_points: 1000)
      ExpiringLoyaltyPointsJob.perform_now
      user.reload
      expect(user.loyalty_points).to eq 1000
    end

    it 'should not provide Coffee reward for the customers having < 90 loyalty points and not birthday month' do
      user.update(loyalty_points: 1000, created_at: DateTime.now - 1.year)
      ExpiringLoyaltyPointsJob.perform_now
      user.reload
      expect(user.loyalty_points).to eq 0
    end
  end
end
