local task = {}

task.cancel = zune.task.cancel
task.defer = zune.task.defer
task.delay = zune.task.delay
task.spawn = zune.task.spawn
task.wait = zune.task.wait

return table.freeze(task)