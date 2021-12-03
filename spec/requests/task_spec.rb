require 'rails_helper'

RSpec.describe 'Request Spec: Task', type: :request do
  before :each do
    sign_in create(:user)
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
    task = Category.create(name: 'Test')
    .tasks.create(
      name: 'Task', 
      details: 'task details', 
      date: Date.today
    )
    get edit_category_task_path(task.category, task)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:edit)
  end

  it 'GET /categories/:category_id/tasks/:id' do
    task = Category.create(name: 'Test')
    .tasks.create(
      name: 'Task', 
      details: 'task details', 
      date: Date.today
    )
    get category_task_path(task.category, task)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:show)
  end
end
