class TasksController < ApplicationController
    before_action :set_task, only: %i[edit update]
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

    def edit;end

    def update
        respond_to do |format|
            if @task.update(task_params)
              format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
              format.json { render :show, status: :ok, location: @task }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @task.errors, status: :unprocessable_entity }
            end
          end
    end

    private

    def set_task
        @task = Task.find(params[:id])
    end
    def task_params
        params.require(:task).permit(:name, :description, :completed, :priority)
    end
end
