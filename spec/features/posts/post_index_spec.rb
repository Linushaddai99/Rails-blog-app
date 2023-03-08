require 'rails_helper'

RSpec.describe 'post#index', type: :feature do
  before :each do
    @user1 = User.create(name: 'Simon', photo: 'https://randomuser.me/api/portraits/men/1.jpg',
                         bio: 'Teacher in South Africa')
    @user2 = User.create(name: 'Peter', photo: 'https://randomuser.me/api/portraits/women/1.jpg',
                         bio: 'Teacher in Australia')

    @post_one = Post.create(author: @user1, title: 'Story', text: 'This is my first post')
    @post_two = Post.create(author: @user1, title: 'Hello', text: 'This is my secound post')

    @comment_one = Comment.create(post: @post_one, author: @user2, text: 'Nice!')

    visit user_posts_path(@user1.id)
  end

  it "can see the user's profile picture" do
    expect(page).to have_css("img[src*='https://randomuser.me/api/portraits/men/1.jpg']")
  end

  it "can see the user's username" do
    expect(page).to have_content('Simon')
  end

  it 'can see the post counter for this user' do
    expect(page).to have_content(@user1.posts_counter)
  end

  it "can see a post's title" do
    expect(page).to have_content('Hello')
  end

  it "can see some of the post's body" do
    expect(page).to have_content('This is my first post')
  end

  it 'can see the first comments on a post' do
    expect(page).to have_content(@comment_one.text)
  end

  it 'can see how many comments a post has' do
    expect(page).to have_content(@user1.posts_counter)
  end

  it 'can see how many likes a post has' do
    expect(page).to have_content(@user1.likes.count)
  end

  it "redirects me to that post's show page" do
    click_link 'Story'
    expect(page).to have_current_path user_post_path(@user1.id, @post_one.id)
  end
end
