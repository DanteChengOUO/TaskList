# frozen_string_literal: true

shared_examples 'a missions list page' do
  it 'shows title' do
    is_expected.to have_content(I18n.t('missions.index.title'))
  end

  it 'shows new mission link' do
    is_expected.to have_content(I18n.t('missions.index.link.create'))
  end

  it 'shows title searching division' do
    is_expected.to have_content(Mission.human_attribute_name(:title))
  end

  it 'shows status searching division' do
    is_expected.to have_content(Mission.human_attribute_name(:status))
    is_expected.to have_content(I18n.t('missions.index.status.all'))
    is_expected.to have_content(Mission.human_enum_name(:statuses, :pending))
    is_expected.to have_content(Mission.human_enum_name(:statuses, :processing))
    is_expected.to have_content(Mission.human_enum_name(:statuses, :completed))
  end

  it 'shows sorting division' do
    is_expected.to have_content(I18n.t('missions.index.field'))
    is_expected.to have_content(Mission.human_attribute_name(:created_at))
    is_expected.to have_content(Mission.human_attribute_name(:ended_at))
    is_expected.to have_content(Mission.human_attribute_name(:priority))
    is_expected.to have_content(I18n.t('missions.index.order'))
    is_expected.to have_content(I18n.t('missions.index.ascending'))
    is_expected.to have_content(I18n.t('missions.index.descending'))
  end
end

shared_examples 'a page that shows the missions' do
  it 'shows the mission' do
    is_expected.to have_content(I18n.t('missions.index.link.edit'))
    is_expected.to have_content(I18n.t('missions.index.link.delete'))
    is_expected.to have_selector('ul > li', text: Mission.human_enum_name(:statuses, mission.status.to_sym))
    is_expected.to have_content(mission.title)
    is_expected.to have_content(mission.content)
    is_expected.to have_content(I18n.l(mission.started_at, time: :default))
    is_expected.to have_content(I18n.l(mission.ended_at, time: :default))
    is_expected.to have_content(I18n.l(mission.created_at, time: :default))
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

shared_examples 'a page that shows only pending missions' do
  it 'shows the mission' do
    is_expected.to have_selector('ul > li', text: Mission.human_enum_name(:statuses, :pending))
    is_expected.to have_no_selector('ul > li', text: Mission.human_enum_name(:statuses, :processing))
    is_expected.to have_no_selector('ul > li', text: Mission.human_enum_name(:statuses, :completed))
  end
end

shared_examples 'a page that shows only processing missions' do
  it 'shows the mission' do
    is_expected.to have_no_selector('ul > li', text: Mission.human_enum_name(:statuses, :pending))
    is_expected.to have_selector('ul > li', text: Mission.human_enum_name(:statuses, :processing))
    is_expected.to have_no_selector('ul > li', text: Mission.human_enum_name(:statuses, :completed))
  end
end

shared_examples 'a page that shows only completed missions' do
  it 'shows the mission' do
    is_expected.to have_no_selector('ul > li', text: Mission.human_enum_name(:statuses, :pending))
    is_expected.to have_no_selector('ul > li', text: Mission.human_enum_name(:statuses, :processing))
    is_expected.to have_selector('ul > li', text: Mission.human_enum_name(:statuses, :completed))
  end
end

shared_examples 'a page that shows no missions' do
  it 'shows the mission' do
    is_expected.to have_no_selector('ul > li', text: Mission.human_enum_name(:statuses, :pending))
    is_expected.to have_no_selector('ul > li', text: Mission.human_enum_name(:statuses, :processing))
    is_expected.to have_no_selector('ul > li', text: Mission.human_enum_name(:statuses, :completed))
  end
end
