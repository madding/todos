class TodosController < ApplicationController
  before_filter :find_todo, only: [:change_status, :destroy, :edit, :update]
  def index
    @todos = Todo.order(:index)
  end

  def new
    @todo = Todo.new
  end

  def update
    if @todo.update_attributes(permited_attributes)
      redirect_to todos_path, notice: 'Задача обновлена'
    else
      respond_to do |format|
        format.js
        format.html { render :edit }
      end
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
    @todo.destroy
    redirect_to todos_path, notice: 'Задача была успешно удалена'
  end

  # в идеале тут нужен вложенный контроллер Statuses с методом update
  def change_status
    if @todo.current_state.events.keys.include?(params[:method].to_sym)
      @todo.send(params[:method] + '!')
    else
      @error = 'Переход на не существующий статус'
    end
  end

  private

  def find_todo
    @todo = Todo.find(params[:id])
  end

  def permited_attributes
    params.require(:todo).permit(:title, :description, :move, :status)
  end
end
