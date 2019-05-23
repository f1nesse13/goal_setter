FactoryBot.define do
  factory :goal do
    title { "MyString" }
    details { "MyText" }
    public { false }
    completed { false }
    user_id { 1 }
  end
end
