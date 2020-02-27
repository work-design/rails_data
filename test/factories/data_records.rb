FactoryBot.define do
  factory :data_record do
    title { "MyString" }
    comment { "MyString" }
    type { 'DataRecord' }
    parameters { "" }
    columns { "" }
    data_table { "MyString" }
    export_excel { "MyString" }
    export_pdf { "MyString" }
  end
end
