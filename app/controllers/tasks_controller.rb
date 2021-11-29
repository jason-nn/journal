class TasksController < ApplicationController
    def create
        @category = Category.find(params[:category_id])
        @task = @category.tasks.create(task_params)
        redirect_to category_path(@category)
    end

    def show
        @category = Category.find(params[:category_id])
        @task = @category.tasks.find(params[:id])
    end

    def edit
        @category = Category.find(params[:category_id])
        @task = @category.tasks.find(params[:id])
    end

    def update
        @category = Category.find(params[:category_id])
        @task = @category.tasks.find(params[:id])
        if @task.update(task_params)
            redirect_to category_path(@category)
        else
            render :edit
        end
    end

    def destroy
        @category = Category.find(params[:category_id])
        @task = @category.tasks.find(params[:id])
        @task.destroy
        redirect_to category_path(@category)
    end

    private

    def task_params
        params.require(:task).permit(:name, :details, :date)
    end
end
