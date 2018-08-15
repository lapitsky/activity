require 'rails_helper'

RSpec.describe Patient, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:physician_name) }

  describe 'activity logging' do
    subject { patient.activity_logs }

    let(:patient) do
      FactoryBot.create(
        :patient,
        first_name: 'John',
        last_name: 'Doe',
        physician_name: 'Dr. Phil')
    end

    context 'when patient is created' do
      its(:count) { is_expected.to eq(1) }
      its('first.changes_text') do
        is_expected.to match(
          /^Created with the following attributes: {"id":#{patient.id},"first_name":"John","last_name":"Doe","physician_name":"Dr\. Phil","created_at":.+,"updated_at":/)
      end
    end

    context 'when patient is updated' do
      let(:updated_attrs) do
        { first_name: 'Jane', last_name: 'Duhn', physician_name: 'Dr. Dre' }
      end

      before { patient.update(updated_attrs) }

      its(:count) { is_expected.to eq(2) }
      its('last.changes_text') do
        is_expected.to match(
          /^Updated first_name from "John" to "Jane", last_name from "Doe" to "Duhn", and physician_name from "Dr\. Phil" to "Dr\. Dre"$/)
      end

      context 'when one field is updated' do
        let(:updated_attrs) { { first_name: 'Julia' } }

        its(:count) { is_expected.to eq(2) }
        its('last.changes_text') do
          is_expected.to match(/^Updated first_name from "John" to "Julia"$/)
        end
      end

      context 'when update failed' do
        let(:updated_attrs) { { first_name: '' } }

        its(:count) { is_expected.to eq(1) }
      end
    end
  end
end
