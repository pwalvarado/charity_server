FactoryGirl.define do
  factory :auction do
    association :organization, strategy: :build
    starts_at "2015-11-25 07:44:27"
    ends_at "2015-11-25 07:45:27"
    time_zone_id "America/Bogota"
    physical_address "MyText"
    name "MyString"
    donation_window_ends_at "2015-11-25 07:43:27"
  end

end
