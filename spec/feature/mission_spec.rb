require 'rails_helper'
Capybara.current_driver = :rack_test

RSpec.describe 'Missions List', type: :feature do
  subject { page }
  
  def find_mission(mission)
    Mission.find_by(title: mission.title).id
  end

  let!(:mission) { FactoryBot.create(:mission) }
  let!(:new_mission) { FactoryBot.create(:mission) }
  let!(:updated_mission) { FactoryBot.create(:mission) }

  before do
    visit missions_path
  end
 
  it do
    is_expected.to have_content('任務列表')
    is_expected.to have_content('新增任務')
  end
  
  context 'when there are missions' do
    it 'shows the missions' do
      is_expected.to have_content('任務列表')
      is_expected.to have_content('新增任務')
      is_expected.to have_content('修改任務')
      is_expected.to have_content('刪除任務')
      is_expected.to have_content("#{mission.title}")
      is_expected.to have_content("#{mission.content}")
      is_expected.to have_content("#{mission.started_at.strftime('%Y/%m/%d %H:%M')}")
      is_expected.to have_content("#{mission.ended_at.strftime('%Y/%m/%d %H:%M')}")
    end
  end
  
  describe 'Adding missions' do
    before do
      visit new_mission_path
      fill_in 'Title', with: new_mission.title
      fill_in 'Content', with: new_mission.content
      fill_in 'Started at', with: new_mission.started_at
      fill_in 'Ended at', with: new_mission.ended_at
      click_button '建立任務'
    end

    it 'adds missions' do
      is_expected.to have_content('任務列表')
      is_expected.to have_content('新增任務')
      is_expected.to have_content('修改任務')
      is_expected.to have_content('刪除任務')
      is_expected.to have_content("#{new_mission.title}")
      is_expected.to have_content("#{new_mission.content}")
      is_expected.to have_content("#{new_mission.started_at.strftime('%Y/%m/%d %H:%M')}")
      is_expected.to have_content("#{new_mission.ended_at.strftime('%Y/%m/%d %H:%M')}")
    end
  end

  describe 'Updating missions' do
    before do
      visit edit_mission_path(find_mission(new_mission))
      fill_in 'Title', with: updated_mission.title
      fill_in 'Content', with: updated_mission.content
      fill_in 'Started at', with: updated_mission.started_at
      fill_in 'Ended at', with: updated_mission.ended_at
      click_button '修改任務'
    end

    it 'updates missions' do
      is_expected.to have_content('任務列表')
      is_expected.to have_content('新增任務')
      is_expected.to have_content('修改任務')
      is_expected.to have_content('刪除任務')
      is_expected.to have_content("#{updated_mission.title}")
      is_expected.to have_content("#{updated_mission.content}")
      is_expected.to have_content("#{updated_mission.started_at.strftime('%Y/%m/%d %H:%M')}")
      is_expected.to have_content("#{updated_mission.ended_at.strftime('%Y/%m/%d %H:%M')}")
    end
  end

  describe 'Deleting missions' do
    before do
      find("a[href='/missions/#{find_mission(updated_mission)}']").click
    end

    it 'deletes missions' do
      is_expected.to have_content('任務列表')
      is_expected.to have_content('新增任務')
      is_expected.to have_no_content("#{updated_mission.title}")
      is_expected.to have_no_content("#{updated_mission.content}")
    end
  end    
end

