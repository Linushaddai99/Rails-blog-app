require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'test user', photo: 'photo url', bio: 'bio text', posts_counter: 0) }

  before { subject.save }

  # before { subject.save }
  # describe 'validations' do
  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is valid with a name' do
    subject.name = 'Ifeanyi'
    expect(subject).to be_valid
  end

  it 'is not valid with a negative post counter' do
    subject.posts_counter = -1
    expect(subject).not_to be_valid
  end

  it 'is valid with a zero post counter' do
    subject.posts_counter = 0
    expect(subject).to be_valid
  end

  it 'is valid with a positive post counter' do
    subject.posts_counter = 1
    expect(subject).to be_valid
  end
  # end
end
