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
    is_expected.to have_content(I18n.t('admin.users.index.authority'))
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

shared_examples 'a page that shows user without deleted user' do
  it 'shows the user' do
    is_expected.to have_no_content(to_be_delete_user.name)
    is_expected.to have_no_content(to_be_delete_user.email)
  end
end
