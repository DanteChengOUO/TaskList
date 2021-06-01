# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Missions List', type: :feature do
  def fill_in_form(mission)
    fill_in Mission.human_attribute_name(:title), with: mission.title
    fill_in Mission.human_attribute_name(:content), with: mission.content
    fill_in Mission.human_attribute_name(:started_at), with: mission.started_at
    fill_in Mission.human_attribute_name(:ended_at), with: mission.ended_at
  end

  subject { page }
  describe 'Showing missions' do
    context 'when there is no misson' do
      before { visit missions_path }
      it_behaves_like 'a missions list page'
    end

    context 'when there are missions' do
      let!(:mission) { create(:mission) }
      before { visit missions_path }

      it_behaves_like 'a missions list page'
      it_behaves_like 'a page that shows the missions'
    end
  end

  describe 'Sorting mission' do
    let!(:first_mission) { create(:mission) }
    let!(:second_mission) { create(:mission, created_at: DateTime.now + 1, ended_at: DateTime.now + 2) }
    let!(:third_mission) { create(:mission, created_at: DateTime.now + 2, ended_at: DateTime.now + 3) }

    context 'when goes to root' do
      before { visit missions_path }

      it_behaves_like 'a missions list page'
      it_behaves_like 'a page that shows the missions sort by desc'
    end

    context 'when created_at order by desc' do
      before { visit missions_path(field: :created_at, order: :DESC) }

      it_behaves_like 'a missions list page'
      it_behaves_like 'a page that shows the missions sort by desc'
    end

    context 'when created_at order by asc' do
      before { visit missions_path(field: :created_at, order: :ASC) }

      it_behaves_like 'a missions list page'
      it_behaves_like 'a page that shows the missions sort by asc'
    end

    context 'when get Unexpected params' do
      let(:Unexpected) { Faker::String.random }
      before { visit missions_path(field: :Unexpected, order: :Unexpected) }

      it_behaves_like 'a missions list page'
      it_behaves_like 'a page that shows the missions sort by desc'
    end
  end

  describe 'Adding missions' do
    let(:mission) { build(:mission) }

    before do
      visit new_mission_path
      fill_in_form(mission)
      click_button I18n.t('missions.button.submit')
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
      click_button I18n.t('missions.button.submit')
    end

    it_behaves_like 'a missions list page'
    it_behaves_like 'a page that shows the missions'
  end

  describe 'Deleting missions' do
    def destroy_link(mission)
      "a[href=\"#{mission_path(mission)}\"][data-method=\"delete\"]"
    end

    let!(:mission) { create(:mission) }

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
