require 'rails_helper'

RSpec.describe 'System Spec: Categories', type: :system do
    before { driven_by(:rack_test) }

    before :all do
      @avion = Category.create(name: 'Avion')
      @avion.tasks.create(
        name: 'System Specs',
        details: 'write system specs for journal app',
        date: Date.today
      )
    end

    after :all do
      @avion.destroy
    end

    describe 'All Categories' do

      before :each do
        visit categories_path
      end

      it 'shows title' do
        expect(page).to have_content('Categories')
      end

      it 'shows all categories' do
        expect(page).to have_content('Avion')
      end

      it 'has a button that goes to create a new category' do
        click_on 'New Category'
        expect(page).to have_content('New Category')
        expect(page).to have_content('Name')
      end
      
      it 'has a button that goes to today\'s tasks' do
        click_on 'Back'
        expect(page).to have_content('Today\'s Tasks')
        expect(page).to have_content(Date.today)
      end

    end

    describe 'Creating a Category' do
      
      before :each do
        visit categories_path
        click_on 'New Category'
        fill_in 'Name', with: 'Ateneo'
        click_on 'Create Category'
      end
      
      it 'creates a category' do
        expect(page).to have_content('Ateneo')
      end

      it 'shows a success notice' do
        expect(page).to have_content('Category was successfully created.')
      end

    end

    describe 'Reading a Category' do

      before :each do
        visit categories_path
        click_on 'Show'
      end
    
      it 'shows category name' do
        expect(page).to have_content('Avion')
      end

      it 'shows tasks header' do
        expect(page).to have_content('Tasks')
      end

      it 'shows tasks' do
        expect(page).to have_content('System Specs')
      end

      it 'has a button that goes to edit' do
        click_on 'Edit'
        expect(page).to have_content('Edit Category')
      end

      it 'has a button that goes to back to all categories' do
        click_on 'Back'
        expect(page.html).to have_content('Categories')
        expect(page.html).to have_content('Avion')
      end

    end

    describe 'Updating a Category' do

      before :each do
        visit category_path(@avion)
        click_on 'Edit'
        fill_in 'Name', with: 'Avion School'
        click_on 'Update Category'
      end
    
      it 'updates a category' do
        expect(page).to have_content('Avion School')
      end

      it 'shows a success notice' do
        expect(page).to have_content('Category was successfully updated.')
      end

    end

    describe 'Destroying a Category' do

      before :each do
        visit categories_path
        click_on 'Destroy'
      end
    
      it 'destroys a task' do
        expect(page).not_to have_content('Avion')
      end

      it 'shows a success notice' do
        expect(page).to have_content('Category was successfully destroyed.')
      end

    end

end
