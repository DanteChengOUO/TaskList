# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mission, type: :model do
  let(:title_blank_error) { I18n.t('activerecord.errors.models.mission.attributes.title.blank') }
  let(:title_too_long_error) { I18n.t('activerecord.errors.models.mission.attributes.title.too_long') }
  let(:content_blank_error) { I18n.t('activerecord.errors.models.mission.attributes.content.blank') }
  let(:status_blank_error) { I18n.t('activerecord.errors.models.mission.attributes.status.blank') }

  it { is_expected.to validate_presence_of(:title).with_message(title_blank_error) }
  it { is_expected.to validate_length_of(:title).is_at_most(50).with_message(title_too_long_error) }
  it { is_expected.to validate_presence_of(:content).with_message(content_blank_error) }
  it { is_expected.to validate_presence_of(:status).with_message(status_blank_error) }

  describe '#ended_at validation' do
    context 'When #ended_at is bigger than #started_at' do
      subject(:mission) { build(:mission) }

      it { is_expected.to be_valid }
    end

    context 'When #ended_at is less than #started_at' do
      subject(:mission) { build(:mission, started_at: DateTime.now + 1, ended_at: DateTime.now) }
      let(:error_message) { I18n.t('activerecord.errors.models.mission.attributes.ended_at.before_start_time') }

      before { mission.save }

      it { is_expected.to be_invalid }
      it { expect(mission.errors.messages[:ended_at]).to include error_message }
    end
  end
end
