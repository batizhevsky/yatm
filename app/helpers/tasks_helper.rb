# encoding: utf-8

module TasksHelper
  def set_me_assigned_to_task(task)
    button_to("Назначить меня", task_path(task, task: { user_id: current_user }), method: :patch, class: 'btn btn-mini')
  end
end
