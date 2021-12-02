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

end
