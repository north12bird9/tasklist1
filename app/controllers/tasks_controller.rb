class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :show, :edit, :update]
  
  def index
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(4)
  end

  def show
    set_task
  end

  def new
    @task = Task.new 
  end

  def create
    @task = current_user.tasks.new (task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に投稿されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが投稿されませんでした。'
      render :new
    end
  end

  def edit
    set_task
  end

  def update
    set_task
    
    if @task.update(task_params)
      flash[:success] = 'タスクが更新されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした。'
      render :edit
    end
  end  

  def destroy
    set_task
    @task.destroy
    
    flash[:success] = 'タスクは削除されました。'
    redirect_to tasks_url
  end
  
  private

 def set_task
   @task = Task.find(params[:id])
 end

 def task_params
  params.require(:task).permit(:content, :status)
 end
 
 def correct_user
    @tasks = current_user.tasks.find_by(id: params[:id])
    unless @tasks
      redirect_to tasks_url
    end
 end

end

