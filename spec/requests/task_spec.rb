require 'rails_helper'

RSpec.describe 'Request Spec: Task', type: :request do
  before :each do
    @user = create(:user)
    sign_in @user
  end

  it 'GET /' do
    get '/'
    expect(response).to have_http_status(200)
    expect(response).to render_template(:today)
  end

  it 'GET /tasks' do
    get '/tasks'
    expect(response).to have_http_status(200)
    expect(response).to render_template(:all)
  end

  it 'GET /categories/:category_id/tasks/:id/edit' do
    task = Category.create(name: 'Test', user_id: @user.id)
    .tasks.create(
      name: 'Task', 
      details: 'task details', 
      date: Date.today, 
      user_id: @user.id  
    )
    get edit_category_task_path(task.category, task)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:edit)
  end

  it 'GET /categories/:category_id/tasks/:id' do
    task = Category.create(name: 'Test', user_id: @user.id)
    .tasks.create(
      name: 'Task', 
      details: 'task details', 
      date: Date.today, 
      user_id: @user.id
    )
    get category_task_path(task.category, task)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:show)
  end
end
