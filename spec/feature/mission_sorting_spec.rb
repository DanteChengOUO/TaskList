# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sorting missions feature', type: :feature do
  subject { page }

  describe 'Sorting missions' do
    let!(:first_mission) { create(:mission, created_at: DateTime.now, ended_at: DateTime.now + 1) }
    let!(:second_mission) { create(:mission, created_at: DateTime.now + 1, ended_at: DateTime.now + 2) }
    let!(:third_mission) { create(:mission, created_at: DateTime.now + 2, ended_at: DateTime.now + 3) }

    context 'when visiting mission list' do
      before { visit missions_path }

      it_behaves_like 'a missions list page'
      it_behaves_like 'a page that shows the missions sort by desc'
    end

    describe 'Sorting by created_at' do
      context 'when order by desc' do
        before { visit missions_path(field: :created_at, order: :DESC) }

        it_behaves_like 'a missions list page'
        it_behaves_like 'a page that shows the missions sort by desc'
      end

      context 'when order by asc' do
        before { visit missions_path(field: :created_at, order: :ASC) }

        it_behaves_like 'a missions list page'
        it_behaves_like 'a page that shows the missions sort by asc'
      end
    end

    describe 'Sorting by ended_at' do
      context 'when order by desc' do
        before { visit missions_path(field: :ended_at, order: :DESC) }

        it_behaves_like 'a missions list page'
        it_behaves_like 'a page that shows the missions sort by desc'
      end

      context 'when order by asc' do
        before { visit missions_path(field: :ended_at, order: :ASC) }

        it_behaves_like 'a missions list page'
        it_behaves_like 'a page that shows the missions sort by asc'
      end
    end

    context 'when both field and order get unexpected params' do
      let(:random_string) { Faker::String.random }
      before { visit missions_path(field: :random_string, order: :random_string) }

      it_behaves_like 'a missions list page'
      it_behaves_like 'a page that shows the missions sort by desc'
    end

    context 'when only order get unexpected params' do
      let(:random_string) { Faker::String.random }
      before { visit missions_path(order: :random_string) }

      it_behaves_like 'a missions list page'
      it_behaves_like 'a page that shows the missions sort by desc'
    end

    context 'when only field get unexpected params' do
      let(:random_string) { Faker::String.random }
      before { visit missions_path(field: :random_string) }

      it_behaves_like 'a missions list page'
      it_behaves_like 'a page that shows the missions sort by desc'
    end
  end
end
