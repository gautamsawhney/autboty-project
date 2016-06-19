require 'rails_helper'

  context "json API" do

    describe "Create" do

      let(:user) { FactoryGirl.create :user } #create
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" } #create
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
      end
      context "with valid attributes" do
        it "should create the location" do
          expect { post "/api/v1/locations?auth_token=#{user.authtokens.first.token}", location: FactoryGirl.build(:location).attributes.symbolize_keys, format: :json }.to change(Location, :count).by(1)
        end

        it 'responds with 201' do
          post "/api/v1/locations?auth_token=#{user.authtokens.first.token}", location: FactoryGirl.build(:location).attributes.symbolize_keys, format: :json
          expect(response).to have_http_status(201)
        end
      end

    end  


    describe "Index" do 

      let(:user) { FactoryGirl.create :user } #index
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
        3.times { FactoryGirl.create :location}
      end

      it "should fetch the correct number of locations" do
        get "/api/v1/locations?auth_token=#{user.authtokens.first.token}", page: 1, per: 2
        expect(json_response.count == 2).to eql(true)
      end

      it "should fetch the correct locations" do
        get "/api/v1/locations?auth_token=#{user.authtokens.first.token}", page: 1, per: 2
        json_response1 = json_response.clone
        get "/api/v1/locations?auth_token=#{user.authtokens.first.token}", page: 2, per: 2
        json_response2 = json_response.clone
        expect(json_response1.collect { |j1| j1['id'] } + json_response2.collect { |j2| j2['id'] }) .to eq(Location.all.collect(&:id))
      end
      
      it "responds with 200" do
        get "/api/v1/locations?auth_token=#{user.authtokens.first.token}", format: :json
        expect(response).to have_http_status(200)
      end

    end

    describe "Show" do 

      let(:user) { FactoryGirl.create :user } #show
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
        @location = FactoryGirl.create :location
      end

      it "should fetch the required location" do
        get "/api/v1/locations/#{@location.id}?auth_token=#{user.authtokens.first.token}", format: :json
        expect(json_response['id']).to eql(@location.id)
      end
      
      it "responds with 200" do
        get "/api/v1/locations/#{@location.id}?auth_token=#{user.authtokens.first.token}", format: :json
        expect(response).to have_http_status(200)
      end
    end

    describe "Destroy" do 

      let(:user) { FactoryGirl.create :user } #destroy
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
        @location = FactoryGirl.create :location
      end

      it "should delete the required location" do
        delete "/api/v1/locations/#{@location.id}?auth_token=#{user.authtokens.first.token}", format: :json
        expect(response.body.empty?).to eql(true)
      end

      it "responds with 204" do
        delete "/api/v1/locations/#{@location.id}?auth_token=#{user.authtokens.first.token}", format: :json
        expect(response).to have_http_status(204)
      end

    end

    describe "Update" do 

      let(:user) { FactoryGirl.create :user } #update
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
        @location = FactoryGirl.create :location
      end

      context "with valid attributes" do
        it "should update the location" do
          location = FactoryGirl.attributes_for(:location)
          location[:User] = "asdfghj"
          put "/api/v1/locations/#{@location.id}?auth_token=#{user.authtokens.first.token}", location: location, format: :json
          @location.reload
          expect(@location.User).to eq("asdfghj")
        end

        it 'responds with 200' do
          location = FactoryGirl.attributes_for(:location)
          location[:User] = "asdfghj"
          put "/api/v1/locations/#{@location.id}?auth_token=#{user.authtokens.first.token}", location: location, format: :json
          @location.reload
          expect(response).to have_http_status(200)
        end
      end

    end
  end


