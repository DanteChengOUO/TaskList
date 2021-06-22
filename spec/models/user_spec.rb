# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:name_blank_error) { I18n.t('activerecord.errors.models.user.attributes.name.blank') }
  let(:email_blank_error) { I18n.t('activerecord.errors.models.user.attributes.email.blank') }
  let(:password_blank_error) { I18n.t('activerecord.errors.models.user.attributes.password.blank') }

  it { is_expected.to validate_presence_of(:name).with_message(name_blank_error) }
  it { is_expected.to validate_presence_of(:email).with_message(email_blank_error) }
  it { is_expected.to validate_presence_of(:password).with_message(password_blank_error) }
  it { is_expected.to have_secure_password }
end
