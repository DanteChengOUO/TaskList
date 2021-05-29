# frozen_string_literal: true

shared_examples 'a missions list page' do
  it do
    is_expected.to have_content('任務列表')
    is_expected.to have_content('新增任務')
  end
end

shared_examples 'a page that shows the missions' do
  it 'shows the mission' do
    is_expected.to have_content('修改任務')
    is_expected.to have_content('刪除任務')
    is_expected.to have_content(mission.title)
    is_expected.to have_content(mission.content)
    is_expected.to have_content(mission.started_at.strftime('%Y/%m/%d %H:%M'))
    is_expected.to have_content(mission.ended_at.strftime('%Y/%m/%d %H:%M'))
  end
end
