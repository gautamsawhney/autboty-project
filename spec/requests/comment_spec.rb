require 'rails_helper'

  context "json API" do

    describe "Create" do

      let(:user) { FactoryGirl.create :user } #create
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" } #create
      @comment_params = FactoryGirl.build(:comment, user: user).attributes
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
      end
      context "with valid attributes" do
        it "should create the comment" do
          expect { post "/api/v1/comments?auth_token=#{user.authtokens.first.token}", comment: @comment_params, format: :json }.to change(Comment, :count).by(1)
        end

        it 'responds with 201' do
          post "/api/v1/comments?auth_token=#{user.authtokens.first.token}", comment: @comment_params, format: :json
          expect(response).to have_http_status(201)
        end
      end

    end  


    describe "Index" do 

      let(:user) { FactoryGirl.create :user } #index
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
        3.times { FactoryGirl.create :comment}
      end

      it "should fetch the correct number of comments" do
        get "/api/v1/comments?auth_token=#{user.authtokens.first.token}", page: 1, per: 2
        expect(json_response.count == 2).to eql(true)
      end

      it "should fetch the correct comments" do
        get "/api/v1/comments?auth_token=#{user.authtokens.first.token}", page: 1, per: 2
        json_response1 = json_response.clone
        get "/api/v1/comments?auth_token=#{user.authtokens.first.token}", page: 2, per: 2
        json_response2 = json_response.clone
        expect(json_response1.collect { |j1| j1['id'] } + json_response2.collect { |j2| j2['id'] }) .to eq(Comment.all.collect(&:id))
      end
      
      it "responds with 200" do
        get "/api/v1/comments?auth_token=#{user.authtokens.first.token}", format: :json
        expect(response).to have_http_status(200)
      end

    end

    describe "Show" do 

      let(:user) { FactoryGirl.create :user } #show
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
        @comment = FactoryGirl.create :comment
      end

      it "should fetch the required comment" do
        get "/api/v1/comments/#{@comment.id}?auth_token=#{user.authtokens.first.token}", format: :json
        expect(json_response['id']).to eql(@comment.id)
      end
      
      it "responds with 200" do
        get "/api/v1/comments/#{@comment.id}?auth_token=#{user.authtokens.first.token}", format: :json
        expect(response).to have_http_status(200)
      end
    end

    describe "Destroy" do 

      let(:user) { FactoryGirl.create :user } #destroy
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
        @comment = FactoryGirl.create :comment
      end

      it "should delete the required comment" do
        delete "/api/v1/comments/#{@comment.id}?auth_token=#{user.authtokens.first.token}", format: :json
        expect(response.body.empty?).to eql(true)
      end

      it "responds with 204" do
        delete "/api/v1/comments/#{@comment.id}?auth_token=#{user.authtokens.first.token}", format: :json
        expect(response).to have_http_status(204)
      end

    end

    describe "Update" do 

      let(:user) { FactoryGirl.create :user } #update
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
        @comment = FactoryGirl.create :comment
      end

      context "with valid attributes" do
        it "should update the comment" do
          comment = FactoryGirl.attributes_for(:comment)
          comment[:title] = "asdfghj"
          put "/api/v1/comments/#{@comment.id}?auth_token=#{user.authtokens.first.token}", comment: comment, format: :json
          @comment.reload
          expect(@comment.title).to eq("asdfghj")
        end

        it 'responds with 200' do
          comment = FactoryGirl.attributes_for(:comment)
          comment[:title] = "asdfghj"
          put "/api/v1/comments/#{@comment.id}?auth_token=#{user.authtokens.first.token}", comment: comment, format: :json
          @comment.reload
          expect(response).to have_http_status(200)
        end
      end

    end
  end


