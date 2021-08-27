require 'rails_helper'

RSpec.describe Building, type: :model do
  let(:building) { create(:building) }
  let(:building_params) { attributes_for :building }
  let(:invalid_country_code) { create(:invalid_country_code) }
  let(:invalid_length_for_name) { create(:invalid_length_for_name) }
  let(:invalid_length_for_street) { create(:invalid_length_for_street) }
  let(:invalid_length_for_neighborhood) { create(:invalid_length_for_neighborhood) }
  let(:invalid_length_for_external_number) { create(:invalid_length_for_external_number) }
  let(:invalid_length_for_city) { create(:invalid_length_for_city) }
  let(:department_with_internal_number) { create(:department_with_internal_number) }
  let(:department_without_internal_number) { create(:department_without_internal_number) }
  let(:commercial_ground_with_internal_number) { create(:commercial_ground_with_internal_number) }
  let(:commercial_ground_without_internal_number) { create(:commercial_ground_without_internal_number) }
  let(:commercial_ground_zero_bathrooms) { create(:commercial_ground_zero_bathrooms) }
  let(:land_zero_bathrooms) { create(:land_zero_bathrooms) }
  let(:invalid_type_cd) { create(:invalid_type_cd) }

  describe 'validations of presence' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:type_cd) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:external_number) }
    it { is_expected.to validate_presence_of(:neighborhood) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:rooms) }
    it { is_expected.to validate_presence_of(:bathrooms) }
    it { is_expected.to_not validate_presence_of(:comments) }

    context 'when a building is a department or a commercial ground' do
      it 'validates presence of internal number' do
        expect(department_with_internal_number).to be_valid
        expect { department_without_internal_number }.to raise_error(ActiveRecord::RecordInvalid)
        expect(commercial_ground_with_internal_number).to be_valid
        expect { commercial_ground_without_internal_number }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'validations of lenght' do
    context 'when the name has more than 128 characteres' do
      it 'raises an error' do
        expect { invalid_length_for_name }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when the street has more than 128 characteres' do
      it 'raises an error' do
        expect { invalid_length_for_street }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when the neigthborhood has more than 128 characteres' do
      it 'raises an error' do
        expect { invalid_length_for_neighborhood }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when the external_number has more than 12 characteres' do
      it 'raises an error' do
        expect { invalid_length_for_external_number }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when the city has more than 64 characteres' do
      it 'raises an error' do
        expect { invalid_length_for_city }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  context 'when a building is a land or a commercial ground' do
    it 'can be created with zero bathrooms' do
      expect(commercial_ground_zero_bathrooms).to be_valid
      expect(land_zero_bathrooms).to be_valid
    end
  end

  context 'when a building has a valid country code ' do
    it 'is created correctly' do
      expect(building).to be_valid
      expect(COUNTRY_CODES).to include(building.country)
    end
  end

  context 'when the country code is not valid' do
    it 'raises an error' do
      expect { invalid_country_code }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'when a building has an invalid type' do
    it 'raises an error' do
      expect { invalid_type_cd }.to raise_error(ArgumentError)
    end
  end

  describe 'external_number format' do
    subject { Building.new(building_params.merge(external_number: external_number)).valid? }

    context 'when the external number has only alphanumerics and dash (-)' do
      let(:external_number) { '123-1asC' }
      it { is_expected.to eq true }
    end

    context 'when the external number does not have only alphanumerics and dash (-)' do
      let(:external_number) { '1%23A$%SD@' }
      it { is_expected.to eq false }

      let(:external_number) { '- 123 -ASD- 123' }
      it { is_expected.to eq false }

      let(:external_number) { '-#123- ASD -123 ' }
      it { is_expected.to eq false }
    end
  end

  describe 'internal_number format' do
    subject { Building.new(building_params.merge(internal_number: internal_number)).valid? }

    context 'when the internal number has only alphanumerics, dash (-) and blank spaces' do
      let(:internal_number) { '-123- ASD -123 ' }
      it { is_expected.to eq true }
    end

    context 'when the internal number does not have only alphanumerics, dash (-) and blank spaces' do
      let(:internal_number) { '1%23A$%SD@' }
      it { is_expected.to eq false }

      let(:internal_number) { '-123-ASD-123@' }
      it { is_expected.to eq false }

      let(:internal_number) { '-#123- ASD -123 ' }
      it { is_expected.to eq false }
    end
  end

  describe 'update' do
    context 'when a building is updated with an invalid type' do
      it { expect { building.update(type_cd: 'car') }.to raise_error(ArgumentError) }
    end

    context 'when a building is updated with an invalid external number' do
      it { expect(building.update(external_number: 'Car 123')).to eq false }
    end

    context 'when a building is updated with an invalid internal number' do
      it { expect(building.update(internal_number: 'Car123-@')).to eq false }
    end
  end
end
