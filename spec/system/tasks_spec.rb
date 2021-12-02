require 'rails_helper'

RSpec.describe 'System Spec: Tasks', type: :system do
    before { driven_by(:rack_test) }

    before :all do
      @avion = Category.create(name: 'Avion')
      @avion.tasks.create(
        name: 'System Specs',
        details: 'write system specs for journal app',
        date: Date.today
      )
      @swarm = Category.create(name: 'Swarm')
      @swarm.tasks.create(
        name: 'Environment Setup',
        details: 'set up local environment and install necessary packages',
        date: Date.tomorrow
      )
    end

    after :all do
      @avion.destroy
      @swarm.destroy
    end

    describe 'Today\'s Tasks' do

      before :each do
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

      it 'has a button that goes to all categories' do
        click_on 'Categories'
        expect(page).to have_content('Categories')
      end
      
      it 'has a button that goes to all tasks' do
        click_on 'Tasks'
        expect(page).to have_content('All Tasks')
      end

    end

    describe 'All Tasks' do

      before :each do
        visit tasks_path
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

      it 'has a button that goes to today\'s tasks' do
        click_on 'Back'
        expect(page).to have_content('Today\'s Tasks')
      end

    end

    describe 'Creating a Task' do
      
      before :each do
        visit category_path(@avion)
        fill_in 'Name', with: 'Presentation'
        fill_in 'Details', with: 'present journal app on Saturday'
        click_on 'Create Task'
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
        visit category_path(@avion)
        click_on 'Show'
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

    end

end
