class TasksController < ApplicationController
    before_action :set_task, only: %i[edit show update destroy]

    def index
        @tasks = Task.all
    end

    def show;end 

    def new
        @task = Task.new
    end

    def create 
        @task = Task.new(task_params)
        @task.member = current_member
        respond_to do |format|
            if @task.save
                format.html { redirect_to tasks_path, notice: t("Task was successfully created!") }
                format.json { render :show, status: :created, location: @task }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @task.errors, status: :unprocessable_entity }
            end
        end
    end

    def edit
        redirect_to tasks_path, alert: t("You don't have permission to do this action")  unless @task.member == current_member
        redirect_to tasks_path, alert: t("this task was completed!")  if @task.completed
    end

    def update
        respond_to do |format|
            if @task.update(task_params)
              format.html { redirect_to task_url(@task), notice: t("Task was successfully updated!") }
              format.json { render :show, status: :ok, location: @task }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @task.errors, status: :unprocessable_entity }
            end
          end
    end

    def destroy 
        if @task.member == current_member && !@task.completed
            @task.destroy!
            respond_to do |format|
                format.html { redirect_to tasks_url, notice: t("Task was successfully destroyed!") }
                format.json { head :no_content }
            end
        else
            redirect_to tasks_path, alert: t("You don't have permission to do this action")  
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
