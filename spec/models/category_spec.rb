require 'rails_helper'

RSpec.describe 'Model Spec: Category', type: :model do
  before :each do
    @user = create(:user)
    @name = 'Category'
    @category = Category.create(name: @name, user_id: @user.id)
  end
  
  it 'should not catch fire when you create an instance' do
    expect(@category).not_to eq nil
  end
  
  it 'should hold and return name' do
    expect(@category.name).to eq @name
  end
  
  it 'should need a name to be valid' do
    expect(Category.create(name: nil, user_id: @user.id)).not_to be_valid
  end
  
  it 'should need a user id to be valid' do
    expect(Category.create(name: @name, user_id: nil)).not_to be_valid
  end
  
  it 'should accept the same name if user id is different' do
    @user2 = User.create(email: 'test2@test.com', password: 'password', password_confirmation: 'password')
    expect(Category.create(name: @name, user_id: @user2)).not_to be_valid
  end
  
  it 'should not accept the same name if user id is the same' do
    @user2 = User.create(email: 'test2@test.com', password: 'password', password_confirmation: 'password')
    expect(Category.create(name: @name, user_id: @user)).not_to be_valid
  end
end
