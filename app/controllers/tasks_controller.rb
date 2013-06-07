class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all.decorate
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params.merge(creator: current_user))

    respond_to do |format|
      if @task.save
        msg = "Task with ##{ @task.id } \"#{@task.title}\" created by #{ current_user.decorate.show_name }"
        send_msg_to @task.responsible_id, msg

        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        msg = "Task with ##{ @task.id } \"#{@task.title}\" updated by #{ current_user.decorate.show_name }"
        send_msg_to @task.responsible_id, msg

        format.html { redirect_to :back || @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
        format.js 
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id]).decorate
  end

  def set_user
    @users = User.all.decorate
  end

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :user_id, :responsible_id)
  end
end
