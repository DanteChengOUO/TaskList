# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login page', type: :feature do
  def fill_in_login(user)
    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: user.password
  end

  subject { page }

  context 'when user visit login page' do
    before { visit login_path }

    it_behaves_like 'a login page'
  end

  context 'when user logout' do
    let(:user) { create(:user) }

    before do
      visit login_path
      fill_in_login(user)
      click_button I18n.t('sessions.new.login')
      click_link I18n.t('shared.navbar.link.logout')
    end

    it_behaves_like 'a login page'
  end
end
