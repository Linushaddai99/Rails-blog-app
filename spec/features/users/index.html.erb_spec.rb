require 'rails_helper';

RSpec.describe 'user#index' do

    before :each do
        @user_1 = User.create(name: 'Simon', photo: 'https://randomuser.me/api/portraits/men/1.jpg', bio: 'Teacher in South Africa')
        @user_2 = User.create(name: 'Peter', photo: 'https://randomuser.me/api/portraits/women/1.jpg', bio: 'Teacher in Australia')

        user_one = Post.create(author: @user_1, title: 'Hello', text: 'This is my first post')
        user_one = Post.create(author: @user_1, title: 'Hello', text: 'This is my secound post')
        user_two = Post.create(author: @user_2, title: 'Hello', text: 'This is my first post')
        user_two = Post.create(author: @user_2, title: 'Hello', text: 'This is my second post')

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
        expect(page).to have_current_path user_path(@user_1.id)
    end
end