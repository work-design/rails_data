FactoryGirl.define do

  factory :user do

  end

  factory :report_list do
    association :reportable, factory: :user
    reportable_type 'User'
    reportable_id 1
    reportable_name 'user_test'
  end

end
