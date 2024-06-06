class TasksController < ApplicationController
    
    def new
        @task = Task.new
    end

    def create 
        @task = Task.new(task_params)
        @task.member = current_member
        respond_to do |format|
            if @task.save
                format.html { redirect_to tasks_path, notice: "Task was successfully created." }
                format.json { render :show, status: :created, location: @task }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @task.errors, status: :unprocessable_entity }
            end
        end
    end

    private

    def task_params
        params.require(:task).permit(:name, :description, :completed, :priority)
    end
end
