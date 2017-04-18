$(function(){
  $('.todos').on('click', '.up_index_button', function() {
    todo = $(this).parents('.todo');
    prev_todo = todo.prev();
    if (prev_todo.hasClass('todo')) {
      $.post(Routes.todo_path(todo.data('todo-id')), {_method: 'put', todo: { move: 'up'}}).
        success(function(){
          deattached_todo = todo.detach();
          prev_todo.before(deattached_todo);
        });
    };

    return false;
  });

  $('.todos').on('click', '.down_index_button', function() {
    todo = $(this).parents('.todo');
    next_todo = todo.next();
    if (next_todo.hasClass('todo')) {
      $.post(Routes.todo_path(todo.data('todo-id')), {_method: 'put', todo: { move: 'down'}}).
        success(function(){
          deattached_todo = todo.detach();
          next_todo.after(deattached_todo);
        });
    };

    return false;
  });

  $('.todos').on('click', '.change_status', function() {
    console.log( $( this ).text() );
    todo = $(this).parents('.todo');
    $.post(Routes.change_status_todo_path(todo.data('todo-id')), {_method: 'put', method: $(this).data('method')})
    return false;
  });
});
