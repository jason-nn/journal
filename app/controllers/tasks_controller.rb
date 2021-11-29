class TasksController < ApplicationController
    def create
        @category = Category.find(params[:category_id])
        @comment = @category.tasks.create(task_params)
        redirect_to category_path(@category)
    end

    private

    def task_params
        params.require(:task).permit(:name, :details, :date)
    end
end
