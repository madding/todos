class Todo < ActiveRecord::Base
  include Workflow
  workflow_column :status

  attr_accessor :move
  validates :title, presence: true
  validates :index, uniqueness: true

  before_validation :set_index, :move_todo

  workflow do
    state :new do
      event :to_work, transitions_to: :working
    end
    state :working do
      event :to_new, transitions_to: :new
      event :complete, transitions_to: :completed
    end
    state :completed do
      event :to_new, transitions_to: :new
    end
  end

  def status_pretty
    I18n.t("todo.status.#{status}")
  end

  def move_todo
    return unless %w(up down).include?(move)
    new_index = move_up? ? index - 1 : index + 1

    changed_todo = Todo.find_by(index: new_index)
    if changed_todo.blank?
      errors.add(:base, move_up? ? 'Нельзя поднять приоритет' : 'Нельзя уменьшить приоритет')
      return false
    end
    transaction do
      changed_todo.update_column(:index, index)
      update_column(:index, new_index)
    end
  end

  def move_up?
    move == 'up'
  end

  # чтобы не было дублей, номер надо ставить либо с локом, либо в БД
  def set_index
    self.index = Todo.maximum(:index).to_i + 1 if index.blank?
  end
end
