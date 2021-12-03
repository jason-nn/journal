class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_id
  before_action :set_category, only: %i[create show edit update destroy]
  before_action :set_category_task, only: %i[show edit update destroy]

  def today
    @tasks = Task.where(date: Date.today, user_id: @user_id)
  end

  def all
    @tasks = Task.where(user_id: @user_id)
  end

  def create
    @task = @category.tasks.new(task_params)

    if @task.save
      redirect_to category_path(@category),
        notice: 'Task was successfully created.'
    else
      redirect_to category_path(@category),
        alert: 'Task was not successfully created. Please fill in all fields.'
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to category_path(@category),
        notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to category_path(@category),
      notice: 'Task was successfully destroyed.'
  end

  private

  def set_user_id
    @user_id = current_user.id
  end

  def set_category
    @category = Category.find(params[:category_id])
  end
  
  def set_category_task
    @task = @category.tasks.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:name, :details, :date, :user_id).merge(user_id: @user_id)
  end
end
