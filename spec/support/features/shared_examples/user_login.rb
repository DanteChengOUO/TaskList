# frozen_string_literal: true

shared_examples 'a login page' do
  it 'shows title' do
    is_expected.to have_content(I18n.t('sessions.new.title'))
  end

  it 'shows input division' do
    is_expected.to have_content(User.human_attribute_name(:email))
    is_expected.to have_content(User.human_attribute_name(:password))
  end

  it 'shows register link' do
    is_expected.to have_content(I18n.t('sessions.new.link.register'))
  end
end
