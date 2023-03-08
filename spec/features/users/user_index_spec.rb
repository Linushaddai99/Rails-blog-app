require 'rails_helper'

RSpec.describe 'user#index', type: :feature do
  before :each do
    @user1 = User.create(name: 'Simon', photo: 'https://randomuser.me/api/portraits/men/1.jpg',
                         bio: 'Teacher in South Africa')
    @user2 = User.create(name: 'Peter', photo: 'https://randomuser.me/api/portraits/women/1.jpg',
                         bio: 'Teacher in Australia')

    @post_one = Post.create(author: @user1, title: 'Hello', text: 'This is my first post')
    @post_two = Post.create(author: @user1, title: 'Hello', text: 'This is my secound post')

    visit('/')
  end

  it 'can see the username of all other users' do
    expect(page).to have_content('Simon')
    expect(page).to have_content('Peter')
  end

  it 'can see the photo of all other users' do
    expect(page).to have_css("img[src*='https://randomuser.me/api/portraits/men/1.jpg']")
    expect(page).to have_css("img[src*='https://randomuser.me/api/portraits/women/1.jpg']")
  end

  it 'can see the post counter of all other users' do
    expect(page).to have_content('2')
  end

  it 'links to the users#show page' do
    click_link 'Simon'
    expect(page).to have_current_path user_path(@user1.id)
  end

  it 'links to the users#show page' do
    click_link 'Peter'
    expect(page).to have_current_path user_path(@user2.id)
  end
end
