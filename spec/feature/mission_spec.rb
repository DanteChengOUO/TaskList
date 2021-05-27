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
end
