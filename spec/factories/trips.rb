# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip, :class => 'Trip' do
    name 'Test Trip'
    association :destination, factory: :location, address: 'Austin, TX'
    association :origin, factory: :location, address: 'Dallas, TX'
    start_datetime Time.now.utc + (100)
    transportation 'Car'
    trip_type 'Hitchhiker'
    user
  end
end
