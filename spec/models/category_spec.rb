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
end
