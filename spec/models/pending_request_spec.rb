require 'rails_helper'

RSpec.describe PendingRequest, type: :model do
  let!(:approved_request) { create(:pending_request, status: 'approved') }
  describe 'Scopes' do
    describe '#pending' do
      before do
        create(:pending_request)
        create(:pending_request)
        # after(:create) { |user| user.groups << create(:group) }
      end
      it { expect(described_class.pending.count).to eq 2 }
    end
  end
end
