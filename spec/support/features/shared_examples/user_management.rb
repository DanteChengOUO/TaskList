# frozen_string_literal: true

shared_examples 'a user management page' do
  it 'shows title' do
    is_expected.to have_content(I18n.t('admin.users.index.title'))
  end

  it 'shows management navbar link' do
    is_expected.to have_content(user.name)
    is_expected.to have_content(I18n.t('shared.navbar.link.register'))
    is_expected.to have_content(I18n.t('shared.navbar.link.logout'))
  end

  it 'show the table head' do
    is_expected.to have_content(I18n.t('admin.users.index.operating'))
    is_expected.to have_content(User.human_attribute_name(:role))
    is_expected.to have_content(User.human_attribute_name(:name))
    is_expected.to have_content(User.human_attribute_name(:email))
    is_expected.to have_content(I18n.t('admin.users.index.count'))
  end
end

shared_examples 'a page that shows the user' do
  it 'shows the user' do
    is_expected.to have_content(I18n.t('admin.users.index.link.edit'))
    is_expected.to have_content(I18n.t('admin.users.index.link.delete'))
    is_expected.to have_content(user.name)
    is_expected.to have_content(user.email)
    is_expected.to have_content(user.missions.count)
  end
end

shared_examples 'a page that shows the new user' do
  it 'shows the user' do
    is_expected.to have_content(I18n.t('admin.users.index.link.edit'))
    is_expected.to have_content(I18n.t('admin.users.index.link.delete'))
    is_expected.to have_content(new_user.name)
    is_expected.to have_content(new_user.email)
    is_expected.to have_content(new_user.missions.count)
  end
end

shared_examples 'a page that shows users without deleted user' do
  it 'shows the user' do
    is_expected.to have_no_content(to_be_delete_user.name)
    is_expected.to have_no_content(to_be_delete_user.email)
  end
end

shared_examples 'a page that shows head of Viewing mode' do
  it 'shows title' do
    is_expected.to have_content(I18n.t('admin.users.show.title'))
  end

  it 'shows the table head' do
    is_expected.to have_content(I18n.t('.missions.index.operating'))
    is_expected.to have_content(Mission.human_attribute_name(:status))
    is_expected.to have_content(Mission.human_attribute_name(:priority))
    is_expected.to have_content(Mission.human_attribute_name(:title))
    is_expected.to have_content(Mission.human_attribute_name(:content))
    is_expected.to have_content(Mission.human_attribute_name(:started_at))
    is_expected.to have_content(Mission.human_attribute_name(:ended_at))
    is_expected.to have_content(Mission.human_attribute_name(:created_at))
  end
end

shared_examples 'a page that shows missions in Viewing mode' do
  it 'shows the mission' do
    is_expected.to have_selector('tbody > tr', text: Mission.human_enum_name(:statuses, mission.status))
    is_expected.to have_content(mission.title)
    is_expected.to have_content(mission.content)
    is_expected.to have_content(I18n.l(mission.started_at, time: :default))
    is_expected.to have_content(I18n.l(mission.ended_at, time: :default))
    is_expected.to have_content(I18n.l(mission.created_at, time: :default))
  end
end
