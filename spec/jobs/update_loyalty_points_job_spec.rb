# frozen_string_literal: true

RSpec.describe UpdateLoyaltyPointsJob, type: :job do
  context 'loyalty points in India' do
    let!(:user) { create(:user, :india) }
    let(:transaction) { create(:transaction, user_id: user.id) }

    it 'in India for every $100 the end user spends they receive 10 points' do
      transaction.update(amount: 1000)
      UpdateLoyaltyPointsJob.perform_now(user.id, transaction.id)
      user.reload
      expect(user.loyalty_points).to eq 100
    end
  end

  context 'loyalty points in other countries' do
    let!(:user) { create(:user, :other_country) }
    let(:transaction) { create(:transaction, user_id: user.id) }

    it 'in other countries for every $100 the end user spends they receive 20 points' do
      transaction.update(amount: 1000)
      UpdateLoyaltyPointsJob.perform_now(user.id, transaction.id)
      user.reload
      expect(user.loyalty_points).to eq 200
    end
  end
end
