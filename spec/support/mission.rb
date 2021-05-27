FactoryBot.define do

  factory :mission, class: 'Mission' do
    title { 'title' }
    content { 'content' }
    started_at { DateTime.new(2021, 5, 21, 10, 2, 0) }
    ended_at { DateTime.new(2022, 6, 22, 11, 3, 0) }
  end
end
