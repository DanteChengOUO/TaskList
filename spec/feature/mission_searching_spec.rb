# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Searching missions feature', type: :feature do
  def fill_in_login_form(user)
    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: user.password
  end

  subject { page }
  let(:user) { create(:user) }

  before do
    visit login_path
    fill_in_login_form(user)
    click_button I18n.t('sessions.new.login')
  end

  describe 'Searching missions' do
    describe 'Searching by status' do
      describe 'Pending status' do
        let!(:processing_mission) { create(:mission, :processing, user: user) }
        let!(:completed_mission) { create(:mission, :completed, user: user) }

        context 'When has missions match condition' do
          let!(:pending_mission) { create(:mission, :pending, user: user) }

          before do
            visit missions_path
            select(Mission.human_enum_name(:statuses, :pending), from: 'q[status_eq]')
            click_button I18n.t('missions.index.submit')
          end

          it_behaves_like 'a missions list page'
          it_behaves_like 'a page that shows only pending missions'
        end

        context 'When has\'t missions match condition' do
          before do
            visit missions_path
            select(Mission.human_enum_name(:statuses, :pending), from: 'q[status_eq]')
            click_button I18n.t('missions.index.submit')
          end

          it_behaves_like 'a missions list page'
          it_behaves_like 'a page that shows no missions'
        end
      end

      describe 'processing status' do
        let!(:pending_mission) { create(:mission, :pending, user: user) }
        let!(:completed_mission) { create(:mission, :completed, user: user) }

        context 'When has missions match condition' do
          let!(:processing_mission) { create(:mission, :processing, user: user) }

          before do
            visit missions_path
            select(Mission.human_enum_name(:statuses, :processing), from: 'q[status_eq]')
            click_button I18n.t('missions.index.submit')
          end

          it_behaves_like 'a missions list page'
          it_behaves_like 'a page that shows only processing missions'
        end

        context 'When has\'t missions match condition' do
          before do
            visit missions_path
            select(Mission.human_enum_name(:statuses, :processing), from: 'q[status_eq]')
            click_button I18n.t('missions.index.submit')
          end

          it_behaves_like 'a missions list page'
          it_behaves_like 'a page that shows no missions'
        end
      end

      describe 'completed status' do
        let!(:pending_mission) { create(:mission, :pending, user: user) }
        let!(:processing_mission) { create(:mission, :processing, user: user) }

        context 'When has missions match condition' do
          let!(:completed_mission) { create(:mission, :completed, user: user) }

          before do
            visit missions_path
            select(Mission.human_enum_name(:statuses, :completed), from: 'q[status_eq]')
            click_button I18n.t('missions.index.submit')
          end

          it_behaves_like 'a missions list page'
          it_behaves_like 'a page that shows only completed missions'
        end

        context 'When has\'t missions match condition' do
          before do
            visit missions_path
            select(Mission.human_enum_name(:statuses, :completed), from: 'q[status_eq]')
            click_button I18n.t('missions.index.submit')
          end

          it_behaves_like 'a missions list page'
          it_behaves_like 'a page that shows no missions'
        end
      end
    end

    describe 'Searching by title or tag' do
      let!(:pending_mission) { create(:mission, :pending, user: user, title: 'Test_one') }
      let!(:processing_mission) { create(:mission, :processing, user: user, title: 'Test_two') }
      let!(:completed_mission) { create(:mission, :completed, user: user, title: 'Test_three') }

      before do
        visit missions_path
        fill_in('q[title_or_tags_label_cont_any]', with: search_string)
        click_button I18n.t('missions.index.submit')
      end

      context 'When has missions match title' do
        let(:search_string) { 'test_t' }

        it_behaves_like 'a missions list page'
        it { is_expected.to have_selector('tbody > tr > td.title', count: 2) }
      end

      context 'When has\'t missions match title' do
        let(:search_string) { 'some_nonexistent_title' }

        it_behaves_like 'a missions list page'
        it { is_expected.to have_selector('tbody > tr > td.title', count: 0) }
      end

      context 'When has missions match tag' do
        let(:search_string) { 'Rails' }

        it_behaves_like 'a missions list page'
        it { is_expected.to have_selector('tbody > tr > td.title', count: 3) }
      end

      context 'When has\'t missions match tag' do
        let(:search_string) { 'some_nonexistent_title' }

        it_behaves_like 'a missions list page'
        it { is_expected.to have_selector('tbody > tr > td.title', count: 0) }
      end
    end

    describe 'Searching by status and title' do
      describe 'match condition with title' do
        let!(:pending_mission) { create(:mission, :pending, user: user, title: 'Test_one') }
        let!(:processing_mission) { create(:mission, :processing, user: user, title: 'Test_two') }
        let(:string_title) { 'test' }

        context 'when status match condition' do
          let!(:completed_mission) { create(:mission, :completed, user: user, title: 'Test_three') }

          before do
            visit missions_path
            select(Mission.human_enum_name(:statuses, :completed), from: 'q[status_eq]')
            fill_in('q[title_or_tags_label_cont_any]', with: string_title)
            click_button I18n.t('missions.index.submit')
          end

          it_behaves_like 'a missions list page'
          it_behaves_like 'a page that shows only completed missions'
          it { is_expected.to have_selector('tbody > tr > td.title', count: 1) }
        end

        context 'when status has\'t match condition' do
          before do
            visit missions_path
            select(Mission.human_enum_name(:statuses, :completed), from: 'q[status_eq]')
            fill_in('q[title_or_tags_label_cont_any]', with: string_title)
            click_button I18n.t('missions.index.submit')
          end

          it_behaves_like 'a missions list page'
          it_behaves_like 'a page that shows no missions'
          it { is_expected.to have_selector('tbody > tr > td.title', count: 0) }
        end
      end

      context 'when has\'t match condition with title' do
        let!(:completed_mission) { create(:mission, :completed, user: user, title: 'Test_three') }
        let(:string_title) { 'some_nonexistent_title' }

        before do
          visit missions_path
          select(Mission.human_enum_name(:statuses, :completed), from: 'q[status_eq]')
          fill_in('q[title_or_tags_label_cont_any]', with: string_title)
          click_button I18n.t('missions.index.submit')
        end

        it_behaves_like 'a missions list page'
        it_behaves_like 'a page that shows no missions'
        it { is_expected.to have_selector('tbody > tr > td.title', count: 0) }
      end
    end
  end
end
