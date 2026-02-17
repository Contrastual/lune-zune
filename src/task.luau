local task = {}

--[[
Stops a currently scheduled thread from resuming.
]]
task.cancel = zune.task.cancel

--[[
Defers a thread or function to run at the end of the current task queue.
]]
task.defer = zune.task.defer

--[[
Delays a thread or function to run after `duration` seconds.
]]
task.delay = zune.task.delay

--[[
Instantly runs a thread or function.

If the spawned task yields, the thread that spawned the task will resume, letting the spawned task run in the background.
]]
task.spawn = zune.task.spawn

--[[
Waits for at least the given amount of time.

The minimum wait time possible when using `task.wait` is limited by the underlying OS sleep implementation.
For most systems this means `task.wait` is accurate down to about 5 milliseconds or less.
]]
task.wait = zune.task.wait

return table.freeze(task)