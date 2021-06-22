# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Management List', type: :feature do
  def fill_in_login(user)
    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: user.password
  end

  def fill_in_form(user)
    fill_in User.human_attribute_name(:name), with: user.name
    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: user.password
    fill_in User.human_attribute_name(:password_confirmation), with: user.password
  end

  subject { page }

  let(:user) { create(:user) }
  let(:new_user) { build(:user) }

  before do
    visit login_path
    fill_in_login(user)
    click_button I18n.t('sessions.new.login')
  end

  context 'Showing user' do
    let(:new_user) { user }

    it_behaves_like 'a user management page'
    it_behaves_like 'a page that shows the user'
  end

  describe 'Adding users' do
    before do
      visit new_admin_user_path
      fill_in_form(new_user)
      click_button I18n.t('admin.users.shared.form.submit')
    end

    it_behaves_like 'a user management page'
    it_behaves_like 'a page that shows the user'
    it_behaves_like 'a page that shows the new user'
  end

  describe 'Updating users' do
    before do
      to_be_updated_user = create(:user)
      visit edit_admin_user_path(to_be_updated_user)
      fill_in_form(new_user)
      click_button I18n.t('admin.users.shared.form.submit')
    end

    it_behaves_like 'a user management page'
    it_behaves_like 'a page that shows the new user'
  end

  describe 'Deleting users' do
    def destroy_link(user)
      "a[href=\"#{admin_user_path(user)}\"][data-method=\"delete\"]"
    end

    let!(:to_be_delete_user) { create(:user) }

    before do
      visit admin_users_path
      find(destroy_link(to_be_delete_user)).click
    end

    it_behaves_like 'a user management page'
    it_behaves_like 'a page that shows the user'
    it_behaves_like 'a page that shows user without deleted user'
  end
end
