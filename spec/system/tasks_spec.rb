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
    @swarm = Category.create(name: 'Swarm', user_id: @user.id)
    @swarm.tasks.create(
      name: 'Environment Setup',
      details: 'set up local environment and install necessary packages',
      date: Date.current + 3, 
      user_id: @user.id
    )
  end

  after :all do
    @avion.destroy
    @swarm.destroy
    @user.destroy
  end

  describe 'Today\'s Tasks' do

    before :each do
      sign_in @user
      visit root_path
    end

    it 'shows title' do
      expect(page).to have_content('Today\'s Tasks')
    end

    it 'shows today\'s date' do
      expect(page).to have_content(Date.today)
    end

    it 'shows today\'s tasks' do
      expect(page).to have_content('Category: Avion')
      expect(page).to have_content('System Specs')
      expect(page).to have_content('write system specs for journal app')
    end
    
    it 'only shows today\'s tasks' do
      expect(page).not_to have_content('Category: Swarm')
      expect(page).not_to have_content('Environment Setup')
      expect(page).not_to have_content('set up local environment and install necessary packages')
    end

    it 'has a link that goes to all categories' do
      click_on 'Categories'
      expect(page).to have_content('Categories')
    end
    
    it 'has a link that goes to all tasks' do
      click_on 'All Tasks'
      expect(page).to have_content('All Tasks')
    end

    it 'has a link that goes back to today\'s tasks' do
      click_on 'Today\'s Tasks'
      expect(page).to have_content('Today\'s Tasks')
    end

  end

  describe 'All Tasks' do

    before :each do
      sign_in @user
      visit tasks_path
    end

    after :all do 
      @swarm.destroy
    end

    it 'shows title' do
      expect(page).to have_content('All Tasks')
    end

    it 'shows all tasks' do
      expect(page).to have_content('Category: Avion')
      expect(page).to have_content('System Specs')
      expect(page).to have_content('write system specs for journal app')
      expect(page).to have_content('Category: Swarm')
      expect(page).to have_content('Environment Setup')
      expect(page).to have_content('set up local environment and install necessary packages')
    end

    it 'has a link that goes to all categories' do
      click_on 'Categories'
      expect(page).to have_content('Categories')
    end
    
    it 'has a link that goes to all tasks' do
      click_on 'All Tasks'
      expect(page).to have_content('All Tasks')
    end

    it 'has a link that goes back to today\'s tasks' do
      click_on 'Today\'s Tasks'
      expect(page).to have_content('Today\'s Tasks')
    end

  end

  describe 'Creating a Task' do
    
    before :each do
      sign_in @user
      visit category_path(@avion)
      fill_in 'Name', with: 'Presentation'
      fill_in 'Details', with: 'present journal app on Saturday'
      click_on 'Create Task'
    end

    it 'has a link that goes to all categories' do
      click_on 'Categories'
      expect(page).to have_content('Categories')
    end
    
    it 'has a link that goes to all tasks' do
      click_on 'All Tasks'
      expect(page).to have_content('All Tasks')
    end

    it 'has a link that goes back to today\'s tasks' do
      click_on 'Today\'s Tasks'
      expect(page).to have_content('Today\'s Tasks')
    end
    
    it 'creates a task' do
      expect(page).to have_content('Presentation')
    end

    it 'shows a success notice' do
      expect(page).to have_content('Task was successfully created.')
    end

  end

  describe 'Reading a Task' do

    before :each do
      sign_in @user
      visit category_path(@avion)
      click_on 'Show'
    end

    it 'has a link that goes to all categories' do
      click_on 'Categories'
      expect(page).to have_content('Categories')
    end
    
    it 'has a link that goes to all tasks' do
      click_on 'All Tasks'
      expect(page).to have_content('All Tasks')
    end

    it 'has a link that goes back to today\'s tasks' do
      click_on 'Today\'s Tasks'
      expect(page).to have_content('Today\'s Tasks')
    end
  
    it 'shows task name' do
      expect(page).to have_content('System Specs')
    end

    it 'shows task details' do
      expect(page).to have_content('write system specs for journal app')
    end

    it 'shows task date' do
      expect(page).to have_content(Date.today)
    end

    it 'has a link that goes to back to category' do
      click_on 'Back'
      expect(page.html).to have_content('Avion')
    end

  end

  describe 'Updating a Task' do

    before :each do
      sign_in @user
      visit category_path(@avion)
      click_on 'Edit'
      fill_in 'Name', with: 'Journal System Specs'
      click_on 'Update Task'
    end

    it 'has a link that goes to all categories' do
      click_on 'Categories'
      expect(page).to have_content('Categories')
    end
    
    it 'has a link that goes to all tasks' do
      click_on 'All Tasks'
      expect(page).to have_content('All Tasks')
    end

    it 'has a link that goes back to today\'s tasks' do
      click_on 'Today\'s Tasks'
      expect(page).to have_content('Today\'s Tasks')
    end
  
    it 'updates a task' do
      expect(page).to have_content('Journal System Specs')
    end

    it 'shows a success notice' do
      expect(page).to have_content('Task was successfully updated.')
    end

  end

  describe 'Destroying a Task from Categories' do

    before :each do
      sign_in @user
      visit category_path(@avion)
    end

    it 'has a destroy link' do
      expect(page).to have_content('Destroy')
    end
    
    it 'destroys a task' do
      click_on 'Destroy'
      expect(page).not_to have_content('System Specs')
    end
    
    it 'shows a success notice' do
      click_on 'Destroy'
      expect(page).to have_content('Task was successfully destroyed.')
    end

  end

  describe 'Destroying a Task from All Tasks' do

    before :each do
      sign_in @user
      visit tasks_path
    end

    it 'has a destroy link' do
      expect(page).to have_content('Destroy')
    end
    
    it 'destroys a task' do
      click_on 'Destroy'
      expect(page).not_to have_content('System Specs')
    end
    
    it 'shows a success notice' do
      click_on 'Destroy'
      expect(page).to have_content('Task was successfully destroyed.')
    end

  end
  
  describe 'Destroying a Task from All Tasks' do
    
    before :each do
      sign_in @user
      visit root_path
    end
    
    it 'has a destroy link' do
      expect(page).to have_content('Destroy')
    end
    
    it 'destroys a task' do
      click_on 'Destroy'
      expect(page).not_to have_content('System Specs')
    end
    
    it 'shows a success notice' do
      click_on 'Destroy'
      expect(page).to have_content('Task was successfully destroyed.')
    end

  end

end
