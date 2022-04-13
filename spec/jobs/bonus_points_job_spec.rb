# frozen_string_literal: true

RSpec.describe BonusPointsJob, type: :job do
  context 'bonus points' do
    let!(:user) { create(:user, :india) }
    let(:transaction) { create(:transaction, user_id: user.id) }

    it 'should not provide Bonus points for the customers who did not made transaction > 2000 in current quater' do
      transaction.update(amount: 100)
      loyalty_points = user.loyalty_points
      BonusPointsJob.perform_now
      user.reload
      expect(user.loyalty_points).to eq (loyalty_points)
    end

    it 'should not provide Bonus points for the customers who transaction > 2000 but not in current quater' do
      transaction.update(amount: 100, created_at: DateTime.now - 4.months)
      loyalty_points = user.loyalty_points
      BonusPointsJob.perform_now
      user.reload
      expect(user.loyalty_points).to eq (loyalty_points)
    end

    it 'should provide Bonus points for the customers who made transaction > 2000 in current quater' do
      transaction.update(amount: 2000, created_at: DateTime.now)
      loyalty_points = user.loyalty_points
      BonusPointsJob.perform_now
      user.reload
      expect(user.loyalty_points).to eq (loyalty_points + 100)
    end
  end
end
