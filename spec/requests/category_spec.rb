require 'rails_helper'

RSpec.describe 'Request Spec: Category', type: :request do
  before :each do
    @user = create(:user)
    sign_in @user
  end

  it 'GET /categories' do
    get '/categories'
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
  end

  it 'GET /categories/new' do
    get '/categories/new'
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)
  end
  
  it 'GET /categories/:id/edit' do
    category = Category.create(name: 'Test', user_id: @user.id)
    get edit_category_path(category)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:edit)
  end
  
  it 'GET /categories/:id' do
    category = Category.create(name: 'Test', user_id: @user.id)
    get category_path(category)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:show)
  end
end
