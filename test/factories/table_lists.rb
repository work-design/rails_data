FactoryBot.define do
  factory :table_list do
    data_list
    headers { "MyString" }
    footers { "MyString" }
    parameters { "" }
    timestamp { "MyString" }
    done { false }
    published { false }
  end
end
