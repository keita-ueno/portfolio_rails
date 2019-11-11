require 'rails_helper'

RSpec.describe '投稿管理機能', type: :system do
  let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:post_a) { create(:post, name: '最初の投稿', user: user_a ) }
  
  before do 
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  shared_examples_for 'ユーザーAが作成した投稿が表示される' do
    it { expect(page).to have_content '最初の投稿' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザーAが作成した投稿が表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成した投稿が表示されない' do
        expect(page).to have_no_content '最初の投稿'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit post_path(post_a)
      end

      it_behaves_like 'ユーザーAが作成した投稿が表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_post_path
      fill_in '投稿', with: post_name
      click_button '登録する'
    end

    context '新規作成画面でタイトルを入力したとき' do
      let(:post_name) { '新規作成のテストを書く'}

      it '正常に登録される' do
        save_and_open_page
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面でタイトルを入力しなかったとき' do
      let(:post_name){''}
      it 'エラーになる' do
        within '#error_explanation' do
          expect(page).to have_content 'タイトルを入力してください'
        end
      end
    end
  end
end