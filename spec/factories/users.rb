FactoryGirl.define do

	sequence(:email) { |n| "user#{n}@example.com" }
	
	factory :user do
    email
    password '12345678'
    password_confirmation '12345678'
    #roles :admin
  end

  #roles
factory :associate_software_engineer, class: User do
                    email
                    password '12345678'
                    password_confirmation '12345678'
                    roles :associate_software_engineer
                  end
factory :software_engineer, class: User do
                    email
                    password '12345678'
                    password_confirmation '12345678'
                    roles :software_engineer
                  end
factory :technical_lead, class: User do
                    email
                    password '12345678'
                    password_confirmation '12345678'
                    roles :technical_lead
                  end
factory :business_owner, class: User do
                    email
                    password '12345678'
                    password_confirmation '12345678'
                    roles :business_owner
                  end
factory :business_admin, class: User do
                    email
                    password '12345678'
                    password_confirmation '12345678'
                    roles :business_admin
                  end
  
end
