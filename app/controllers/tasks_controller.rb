class TasksController < ApplicationController
    before_action :set_category, only: %i[create show edit update destroy]
    before_action :set_category_task, only: %i[show edit update destroy]

    def create
        @task = @category.tasks.new(task_params)

        if @task.save
            redirect_to category_path(@category),
                        notice: 'Task was successfully created.'
        else
            redirect_to category_path(@category)
        end
    end

    def show; end

    def edit; end

    def update
        if @task.update(task_params)
            redirect_to category_path(@category),
                        notice: 'Category was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @task.destroy
        redirect_to category_path(@category),
                    notice: 'Category was successfully destroyed.'
    end

    private

    def task_params
        params.require(:task).permit(:name, :details, :date)
    end

    def set_category
        @category = Category.find(params[:category_id])
    end

    def set_category_task
        @task = @category.tasks.find(params[:id])
    end
end
