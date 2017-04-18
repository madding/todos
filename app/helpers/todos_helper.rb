module TodosHelper
  def button_for_change_status(todo)
    cl = 'btn btn-primary change_status'
    if todo.new?
      link_to('В работу', nil, title: 'В работу', data: { method: 'to_work' }, class: cl)
    elsif todo.working?
      link_to('Вернуть обратно', nil, title: 'Вернуть обратно', data: { method: 'to_new' }, class: cl) + ' ' +
        link_to('Выполнена', nil, title: 'Выполнена', data: { method: 'complete' }, class: cl)
    elsif todo.completed?
      link_to('Запустить заново', nil, title: 'Выполнена', data: { method: 'to_new' }, class: cl)
    end
  end

  def status_collection
    Todo.workflow_spec.state_names.map { |state| [I18n.t("todo.status.#{state}"), state] }
  end
end
