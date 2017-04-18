class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end

  def new
    @todo = Todo.new
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])

    if @todo.update_attributes(permited_attributes)
      redirect_to todos_path, notice: 'Задача обновлена'
    else
      render :edit
    end
  end

  def create
    @todo = Todo.new(permited_attributes)

    if @todo.save
      redirect_to todos_path, notice: 'Задача успешно создана'
    else
      render :new
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to todos_path, notice: 'Задача была успешно удалена'
  end

  private

  def permited_attributes
    params.require(:todo).permit(:title, :description)
  end
end
