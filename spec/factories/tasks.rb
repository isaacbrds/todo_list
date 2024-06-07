FactoryBot.define do
    factory :task do
      name { Faker::Name.name }
      priority { [0,1,2].sample }
      description { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
      member
    end
  end