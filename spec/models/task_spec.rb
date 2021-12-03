require 'rails_helper'

RSpec.describe 'Model Spec: Task', type: :model do
    before :each do
        @user = create(:user)
        @category = Category.create(name: 'Category', user_id: @user.id)
        @name = 'Task'
        @details = 'task details'
        @date = Date.today
        @task =
            @category.tasks.create(name: @name, details: @details, date: @date, user_id: @user.id)
    end

    it 'should not catch fire when you create an instance' do
        expect(@task).not_to eq nil
    end

    it 'should hold and return name' do
        expect(@task.name).to eq @name
    end

    it 'should hold and return details' do
        expect(@task.details).to eq @details
    end

    it 'should hold and return date' do
        expect(@task.date).to eq @date
    end

    it 'should need a name to be valid' do
        expect(
            @category.tasks.create(name: nil, details: @details, date: @date),
        ).not_to be_valid
    end

    it 'should need details to be valid' do
        expect(
            @category.tasks.create(name: @name, details: nil, date: @date),
        ).not_to be_valid
    end

    it 'should need a date to be valid' do
        expect(
            @category.tasks.create(name: @name, details: @details, date: nil),
        ).not_to be_valid
    end
end
