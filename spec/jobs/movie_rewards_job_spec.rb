# frozen_string_literal: true

RSpec.describe MovieRewardsJob, type: :job do
  context 'movie rewards' do
    let!(:user) { create(:user, :india) }
    let(:transaction) { create(:transaction, user_id: user.id) }

    it 'should not provide Movie reward for the user first transaction is not > 1000' do
      transaction.update(amount: 1000)
      user.update(created_at: DateTime.now - 3.months)
      MovieRewardsJob.perform_now
      expect(user.rewards.first).to be nil
    end

    it 'should not provide Movie reward for the user first transaction is not > 1000' do
      transaction.update(amount: 900)
      user.update(created_at: DateTime.now - 3.months)
      MovieRewardsJob.perform_now
      expect(user.rewards.first).to be nil
    end

    it 'should provide Movie reward for the user first transaction is > 1000' do
      transaction.update(amount: 1000)
      user.update(created_at: DateTime.now)
      MovieRewardsJob.perform_now
      expect(user.rewards.first.name).to eq 'Free Movie ticket'
    end
  end
end
