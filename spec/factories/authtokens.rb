FactoryGirl.define do
  factory :authtoken do
    token "MyString"
    last_used_at "2016-06-19 13:23:38"
    sign_in_ip ""
    user_agent "MyString"
    device_id "MyString"
    user 
  end
end
