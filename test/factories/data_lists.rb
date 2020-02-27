FactoryBot.define do
  factory :data_list do
    title { "MyString" }
    comment { "MyString" }
    type { 'DataList' }
    parameters { "" }
    columns { "" }
    data_table { "MyString" }
    export_excel { "MyString" }
    export_pdf { "MyString" }
  end
end
