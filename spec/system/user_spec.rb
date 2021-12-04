require 'rails_helper'

RSpec.describe 'System Spec: Tasks', type: :system do
  before { driven_by(:rack_test) }

  before :all do
    @user = create(:user)
    @avion = Category.create(name: 'Avion', user_id: @user.id)
    @avion.tasks.create(
      name: 'System Specs',
      details: 'write system specs for journal app',
      date: Date.today, 
      user_id: @user.id
    )
  end

  after :all do
    @avion.destroy
    @user.destroy
  end

  describe 'Signing in with an existing user' do

    before :each do
      sign_in @user
      visit root_path
    end

    it 'should be able to sign in with existing account' do
      expect(page).to have_content('Today\'s Tasks')
    end

    it 'should show created task in today\'s tasks' do
      expect(page).to have_content('System Specs')
    end

    it 'should show created task in all tasks' do
      click_on 'All Tasks'
      expect(page).to have_content('System Specs')
    end

    it 'should show created category in categories' do
      click_on 'Categories'
      expect(page).to have_content('Avion')
    end

  end

  describe 'Signing up for a new account' do

    before:each do
      visit root_path
      click_on 'Sign up'
      fill_in 'Email', with: 'jason@test.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Sign up'
      visit root_path
    end
    
    it 'should be able to sign up for an account' do
      expect(page).to have_content('Today\'s Tasks')
    end

    it 'should show no tasks message in today\'s tasks' do
      click_on 'Today\'s Tasks'
      expect(page).to have_content 'No tasks for today yet.'
    end

    it 'should show no tasks message in all tasks' do
      click_on 'All Tasks'
      expect(page).to have_content 'No tasks yet.'
    end

    it 'should show no categories message in categories' do
      click_on 'Categories'
      expect(page).to have_content 'No categories yet.'
    end

  end

end
