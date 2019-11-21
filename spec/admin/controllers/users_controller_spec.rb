require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  describe '#index' do
    context 'authenticated user'
      before do
        @user = create(:user, name:'ユーザーA', email: 'a@example.com')
      end

      it 'Response code is 200' do
        expect(response).to have_http_status "200"
      end

      it 'responds successfully' do
        expect(response).to be_success
      end
    end
  end

  describe '#show' do
    context 'authenticated user'
      before do
        @user = create(:user, name:'ユーザーA', email: 'a@example.com')
        @post = create(:post, name: '最初のタスク', user: @user)
      end

      it 'Response code is 200' do
        expect respond_to have_http_status "200"
      end

      it 'responds successfully' do
        expect respond_to be_success
      end
    end


