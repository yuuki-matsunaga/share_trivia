# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let!(:post) { create(:post, title: 'hoge',introduction: 'body') }
  let!(:level_setting) {LevelSetting.create(level: 2)}
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(root_path)に「Share Triviaへようこそ」が表示されているか' do
        expect(page).to have_content 'Share Triviaへようこそ'
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end

  describe "投稿画面(new_post_path)のテスト" do
    before do
     user = User.create(name:"name",email:"bbb@aaadd",password:"aaaaaa")
  	visit new_user_session_path
  	fill_in 'user[name]', with: user.name
  	fill_in 'user[email]', with: user.email
  	fill_in 'user[password]', with: user.password
  	click_button 'ログイン'
      visit new_post_path
    end
    context '表示の確認' do
      it 'posts_new_pathが"/posts/new"であるか' do
        expect(current_path).to eq('/posts/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'post[introduction]', with: Faker::Lorem.characters(number:20)
        find("#post_genre_id").find("option[value='1']").select_option
        #セレクトボックスで選択するのを追加する
        click_button '投稿'
        expect(page).to have_current_path user_level_up_path(User.last)
      end
    end
  end

  describe "投稿一覧のテスト" do
    before do
      visit posts_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content post.title
        expect(page).to have_link post.title
      end
    end
  end

  describe "詳細画面のテスト" do
  before do
    user = User.create(name:"name",email:"bbb@aaadd",password:"aaaaaa")
  	visit new_user_session_path
  	fill_in 'user[name]', with: user.name
  	fill_in 'user[email]', with: user.email
  	fill_in 'user[password]', with: user.password
  	click_button 'ログイン'
  	post = Post.create(user_id: user.id, title: "hoge", introduction:"aaaaaaaa", genre_id: 1)

    visit post_path(post)
    end
    context '表示の確認' do
      it '削除リンクが存在しているか' do
        # expect(page).to have_link 'trash'
        expect(page).to have_css '.trash'

      end
      it '編集リンクが存在しているか' do

        expect(page).to have_css '.edit'
      end
      it '編集の遷移先は編集画面か' do
        edit_link = find_all('a')[9]

        edit_link.click
        expect(current_path).to eq('/posts/' + "2" + '/edit')
      end
    end
    context 'リンクの遷移先の確認' do

    end
    context 'post削除のテスト' do
      it 'postの削除' do
        expect{ post.destroy }.to change{ Post.count }.by(-1)
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end
    context '表示の確認' do
      it '編集前のタイトルと本文がフォームに表示(セット)されている' do
        expect(page).to have_field 'post[title]', with: post.title
        expect(page).to have_field 'post[introduction]', with: post.introduction
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '更新'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'post[introduction]', with: Faker::Lorem.characters(number:20)
        click_button '更新'
        expect(page).to have_current_path post_path(post)
      end
    end
  end
end