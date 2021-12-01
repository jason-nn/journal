require 'rails_helper'

RSpec.describe 'Model Spec: Category', type: :model do
    before :each do
        @name = 'Test Category'
        @category = Category.create(name: @name)
    end

    it 'should not catch fire when you create an instance' do
        expect(@category).not_to eq nil
    end
end
