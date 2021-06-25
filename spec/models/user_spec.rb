# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:name_blank_error) { I18n.t('activerecord.errors.models.user.attributes.name.blank') }
  let(:email_blank_error) { I18n.t('activerecord.errors.models.user.attributes.email.blank') }
  let(:email_taken_error) { I18n.t('activerecord.errors.models.user.attributes.email.taken') }
  let(:password_blank_error) { I18n.t('activerecord.errors.models.user.attributes.password.blank') }
  let(:confirmation_error) { I18n.t('activerecord.errors.models.user.attributes.password_confirmation.confirmation') }
  let(:role_blank_error) { I18n.t('activerecord.errors.models.user.attributes.role.blank') }

  it { is_expected.to validate_presence_of(:name).with_message(name_blank_error) }
  it { is_expected.to validate_presence_of(:email).with_message(email_blank_error) }
  it { is_expected.to validate_presence_of(:password).with_message(password_blank_error) }
  it { is_expected.to validate_confirmation_of(:password).on(:create).with_message(confirmation_error) }
  it { is_expected.to have_secure_password }

  describe 'taken validation' do
    subject { build(:user) }

    it { is_expected.to validate_uniqueness_of(:email).with_message(email_taken_error) }
  end

  describe '#role validation' do
    let!(:admin) { create(:user, role: :admin) }

    context 'when admin more than one' do
      subject(:other_admin) { create(:user, role: :admin) }

      before { other_admin.destroy }

      it { is_expected.to be_valid }
    end

    context 'When admin less than one' do
      let(:error_message) { I18n.t('activerecord.errors.models.user.attributes.role.admin_less_than_one') }

      before { admin.destroy }

      it { is_expected.to be_invalid }
      it { expect(admin.errors.messages[:role]).to include error_message }
    end
  end
end
