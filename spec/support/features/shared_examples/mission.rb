# frozen_string_literal: true

shared_examples 'a missions list page' do
  it do
    is_expected.to have_content(I18n.t('missions.index.title'))
    is_expected.to have_content(I18n.t('missions.index.link.create'))
    is_expected.to have_content(I18n.t('missions.index.ascending'))
    is_expected.to have_content(I18n.t('missions.index.descending'))
    is_expected.to have_content(Mission.human_attribute_name(:created_at))
  end
end

shared_examples 'a page that shows the missions' do
  it 'shows the mission' do
    is_expected.to have_content(I18n.t('missions.index.link.edit'))
    is_expected.to have_content(I18n.t('missions.index.link.delete'))
    is_expected.to have_content(mission.title)
    is_expected.to have_content(mission.content)
    is_expected.to have_content(mission.started_at.strftime('%Y/%m/%d %H:%M'))
    is_expected.to have_content(mission.ended_at.strftime('%Y/%m/%d %H:%M'))
  end
end

shared_examples 'a page that shows the missions sort by desc' do
  it 'shows the mission' do
    is_expected.to have_selector('ul > li:nth-child(1)', text: third_mission.title)
    is_expected.to have_selector('ul > li:nth-child(2)', text: second_mission.title)
    is_expected.to have_selector('ul > li:nth-child(3)', text: first_mission.title)
  end
end

shared_examples 'a page that shows the missions sort by asc' do
  it 'shows the mission' do
    is_expected.to have_selector('ul > li:nth-child(1)', text: first_mission.title)
    is_expected.to have_selector('ul > li:nth-child(2)', text: second_mission.title)
    is_expected.to have_selector('ul > li:nth-child(3)', text: third_mission.title)
  end
end
