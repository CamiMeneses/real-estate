require 'rails_helper'

RSpec.describe BuildingsController do
  let(:building) { create(:building) }
  let(:building_params) { attributes_for :building }

  describe 'GET #index' do
    it 'returns a list of buildings only with id, name, type_cd, city and country' do
      create_list :building, 3
      get :index
      expect(JSON.parse(response.body).count).to eq 3
      expect(JSON.parse(response.body).first.keys).to eq %w[id name type_cd city country]
    end
  end

  describe 'GET #show' do
    it 'returns a specific building' do
      create_list :building, 3
      get :show, params: { 'id': Building.first.id }
      expect(JSON.parse(response.body).keys).to eq %w[id name type_cd street external_number internal_number
                                                      neighborhood city country rooms bathrooms comments
                                                      created_at updated_at]
    end
  end

  describe 'POST #create' do
    it 'creates a building' do
      post :create, params: { 'building': building_params }

      expect(response).to have_http_status(:success)
      expect(Building.count).to eq 1
      expect(JSON.parse(response.body)['building'].keys).to eq %w[id name type_cd street external_number internal_number
                                                      neighborhood city country rooms bathrooms comments
                                                      created_at updated_at]
      expect(JSON.parse(response.body)['building']['name']).to eq 'Casa Blanca'
      expect(JSON.parse(response.body)['building']['type_cd']).to eq 'land'
      expect(JSON.parse(response.body)['building']['street']).to eq 'Avenida Caracas'
      expect(JSON.parse(response.body)['building']['neighborhood']).to eq 'Salitre'
      expect(JSON.parse(response.body)['building']['city']).to eq 'Bogotá'
      expect(JSON.parse(response.body)['building']['country']).to eq 'CO'
      expect(JSON.parse(response.body)['building']['external_number']).to eq '123-asd'
      expect(JSON.parse(response.body)['building']['internal_number']).to eq '123 -qwe'
      expect(JSON.parse(response.body)['building']['rooms']).to eq 2
      expect(JSON.parse(response.body)['building']['bathrooms']).to eq 1.2
    end
  end

  describe 'PUT #update' do
    it 'updates a building' do
      building_params[:name] = 'Casa Verde'
      building_params[:type_cd] = 'department'
      building_params[:street] = 'Avenida Insurgentes'
      building_params[:neighborhood] = 'Polanco'
      building_params[:city] = 'Ciudad de México'
      building_params[:country] = 'MX'
      building_params[:rooms] = 4
      building_params[:bathrooms] = 5.2

      put :update, params: { 'id': building.id, 'building': building_params }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['building'].keys).to eq %w[name type_cd street external_number internal_number
                                                      neighborhood city country rooms bathrooms id comments
                                                      created_at updated_at]
      expect(building.reload.name).to eq 'Casa Verde'
      expect(JSON.parse(response.body)['building']['name']).to eq 'Casa Verde'
      expect(building.reload.type_cd).to eq 'department'
      expect(JSON.parse(response.body)['building']['type_cd']).to eq 'department'
      expect(building.reload.street).to eq 'Avenida Insurgentes'
      expect(JSON.parse(response.body)['building']['street']).to eq 'Avenida Insurgentes'
      expect(building.reload.neighborhood).to eq 'Polanco'
      expect(JSON.parse(response.body)['building']['neighborhood']).to eq 'Polanco'
      expect(building.reload.city).to eq 'Ciudad de México'
      expect(JSON.parse(response.body)['building']['city']).to eq 'Ciudad de México'
      expect(building.reload.country).to eq 'MX'
      expect(JSON.parse(response.body)['building']['country']).to eq 'MX'
      expect(building.reload.rooms).to eq 4
      expect(JSON.parse(response.body)['building']['rooms']).to eq 4
      expect(building.reload.bathrooms).to eq 5.2
      expect(JSON.parse(response.body)['building']['bathrooms']).to eq 5.2
    end
  end
end
