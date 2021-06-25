# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Missions List', type: :feature do
  def fill_in_login_form(user)
    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: user.password
  end

  def fill_in_form(mission)
    fill_in Mission.human_attribute_name(:title), with: mission.title
    fill_in Mission.human_attribute_name(:content), with: mission.content
    fill_in Mission.human_attribute_name(:started_at), with: mission.started_at
    fill_in Mission.human_attribute_name(:ended_at), with: mission.ended_at
  end

  subject { page }
  let(:user) { create(:user) }

  before do
    visit login_path
    fill_in_login_form(user)
    click_button I18n.t('sessions.new.login')
  end

  describe 'Showing missions' do
    context 'when there is no misson' do
      before { visit missions_path }
      it_behaves_like 'a missions list page'
    end

    context 'when there are missions' do
      let!(:mission) { create(:mission, user: user) }

      before { visit missions_path }

      it_behaves_like 'a missions list page'
      it_behaves_like 'a page that shows the missions'
    end

    context 'when goes to missions list page without login' do
      before do
        click_link I18n.t('shared.navbar.link.logout')
        visit missions_path
      end

      it_behaves_like 'a login page'
    end
  end

  describe 'Adding missions' do
    let(:mission) { build(:mission) }

    before do
      visit new_mission_path
      fill_in_form(mission)
      click_button I18n.t('missions.shared.form.submit')
    end

    it_behaves_like 'a missions list page'
    it_behaves_like 'a page that shows the missions'
  end

  describe 'Updating missions' do
    let(:mission) { build(:mission) }

    before do
      to_be_updated_mission = create(:mission)
      visit edit_mission_path(to_be_updated_mission)
      fill_in_form(mission)
      click_button I18n.t('missions.shared.form.submit')
    end

    it_behaves_like 'a missions list page'
    it_behaves_like 'a page that shows the missions'
  end

  describe 'Deleting missions' do
    def destroy_link(mission)
      "a[href=\"#{mission_path(mission)}\"][data-method=\"delete\"]"
    end

    let!(:mission) { create(:mission, user: user) }

    before do
      visit missions_path
      find(destroy_link(mission)).click
    end

    it_behaves_like 'a missions list page'

    it 'deletes missions' do
      is_expected.to have_no_content(mission.title)
      is_expected.to have_no_content(mission.content)
    end
  end
end
