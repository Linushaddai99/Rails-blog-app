require 'rails_helper'

RSpec.describe 'user#show', type: :feature do
  before :each do
    @user1 = User.create(name: 'Simon', photo: 'https://randomuser.me/api/portraits/men/1.jpg', bio: 'Teacher in South Africa')
    @user2 = User.create(name: 'Lilly Brian', photo: 'https://randomuser.me/api/portraits/women/1.jpg', bio: 'Teacher from Poland.')

    @post_one = Post.create(author: @user1, title: 'My First trip to China', text: 'This is my first post')

    Comment.create(post: @post_one, author: @user2, text: 'Nice!')
    Comment.create(post: @post_two, author: @user2, text: 'Great!')

    visit(user_path(@user1.id))
  end

  it 'can see the photo of user' do
    expect(page).to have_css("img[src*='https://randomuser.me/api/portraits/men/1.jpg']")
  end

  it 'can see the username of other user' do
    expect(page).to have_content('Simon')
  end

  it 'can see the number of posts the user has written' do
    expect(page).to have_content(@user1.posts.count)
  end

  it 'can see users bio' do
    expect(page).to have_content('Teacher in South Africa')
  end

  it "can see the user's first 3 posts" do
    most_resent_posts = @user1.three_most_recent_posts
    most_resent_posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it "can see a button that lets me view all of a user's posts" do
    expect(page).to have_button('See all posts')
  end

  it "When I click a user's post, it redirects me to that post's show page" do
    click_link 'My First trip to China'
    expect(page).to have_current_path user_post_path(@user1.id, @post_one.id)
  end

  it "When I click to see all posts, it redirects me to the user's post's index page" do
    click_link 'See all posts'
    expect(page).to have_current_path user_posts_path(@user1.id)
  end
end
