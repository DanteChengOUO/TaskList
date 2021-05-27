require 'rails_helper'

RSpec.describe 'Visit mission path', type: :feature do
  subject { page }

  let!(:new_mission) { FactoryBot.create(:mission) }
   
  context 'when goes to page for showing missions' do
    before do
      visit missions_path
    end

    it 'has mission' do
      is_expected.to have_content('任務列表')
      is_expected.to have_content('新增任務')
      is_expected.to have_content('修改任務')
      is_expected.to have_content('刪除任務')
      is_expected.to have_content("#{new_mission.title}")
      is_expected.to have_content("#{new_mission.content}")
      is_expected.to have_content("#{new_mission.started_at.strftime('%Y/%m/%d %H:%M')}")
      is_expected.to have_content("#{new_mission.ended_at.strftime('%Y/%m/%d %H:%M')}")
    end

    it 'has no mission' do
      is_expected.to have_content('任務列表')
      is_expected.to have_content('新增任務')
    end
  end  

  context 'when goes to page for creating missions' do
    before do
      visit new_mission_path
    end
    
    it 'has label' do
      is_expected.to have_content('任務新增')
      is_expected.to have_content('Title')
      is_expected.to have_content('Content')
      is_expected.to have_content('Started at')
      is_expected.to have_content('Ended at')
    end

    it 'has text_field' do
      is_expected.to have_field(id: 'mission_title')
      is_expected.to have_field(id: 'mission_content')
      is_expected.to have_field(id: 'mission_started_at')
      is_expected.to have_field(id: 'mission_ended_at')
    end

    it 'has button' do
      is_expected.to have_button('建立任務')
    end
  end
  
  context 'when goes to page for editing missions' do
    before do
      visit edit_mission_path(Mission.find_by(title: new_mission.title))
    end
    
    it 'has label' do
      is_expected.to have_content('任務修改')
      is_expected.to have_content('Title')
      is_expected.to have_content('Content')
      is_expected.to have_content('Started at')
      is_expected.to have_content('Ended at')
    end

    it 'has text_field' do
      is_expected.to have_field(id: 'mission_title', with: "#{new_mission.title}")
      is_expected.to have_field(id: 'mission_content', with: "#{new_mission.content}")
      is_expected.to have_field(id: 'mission_started_at', with: "#{new_mission.started_at.strftime('%Y-%m-%dT%H:%M:%S')}")
      is_expected.to have_field(id: 'mission_ended_at', with: "#{new_mission.ended_at.strftime('%Y-%m-%dT%H:%M:%S')}")
    end

    it 'has button' do
      is_expected.to have_button('修改任務')
    end
  end  
end
