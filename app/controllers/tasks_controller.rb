class TasksController < ApplicationController
  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(4)
  end

  def show
    set_message
  end

  def new
    @task = Task.new 
  end

  def create
    @task = Task.new (task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に投稿されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが投稿されませんでした。'
      render :new
    end
  end

  def edit
    set_message
  end

  def update
    set_message
    
    if @task.update(task_params)
      flash[:success] = 'タスクが更新されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした。'
      render :edit
    end
  end  

  def destroy
    set_message
    @task.destroy
    
    flash[:success] = 'タスクは削除されました。'
    redirect_to tasks_url
  end
end

private

def set_message
   @task = Task.find(params[:id])
end

def task_params
  params.require(:task).permit(:content, :status)
end
