FactoryBot.define do
  factory :building do
    name { 'Casa Blanca' }
    type_cd { 'land' }
    street { 'Avenida Caracas' }
    external_number { '123-asd' }
    internal_number { '123 -qwe' }
    neighborhood { 'Salitre' }
    city { 'Bogotá' }
    country { 'CO' }
    rooms { 2 }
    bathrooms { 1.2 }

    factory :department_with_internal_number do
      type_cd { 'department' }
    end

    factory :department_without_internal_number do
      type_cd { 'department' }
      internal_number { '' }
    end

    factory :commercial_ground_with_internal_number do
      type_cd { 'commercial_ground' }
    end

    factory :commercial_ground_without_internal_number do
      type_cd { 'commercial_ground' }
      internal_number { '' }
    end

    factory :commercial_ground_zero_bathrooms do
      bathrooms { 0 }
      type_cd { 'commercial_ground' }
    end

    factory :invalid_type_cd do
      type_cd { 'car' }
    end

    factory :land_zero_bathrooms do
      bathrooms { 0 }
      type_cd { 'land' }
    end

    factory :invalid_country_code do
      country { 'COL' }
    end

    factory :invalid_length_for_name do
      name { Faker::String.random(length: 129) }
    end

    factory :invalid_length_for_street do
      street { Faker::String.random(length: 129) }
    end

    factory :invalid_length_for_neighborhood do
      neighborhood { Faker::String.random(length: 129) }
    end

    factory :invalid_length_for_city do
      city { Faker::String.random(length: 65) }
    end

    factory :invalid_length_for_external_number do
      external_number { Faker::String.random(length: 13) }
    end
  end
end
