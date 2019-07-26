# ParallelForEach.ps1
A simple function that behaves like the builtin ForEach-Object, however it is executed in parallel.
Note: There is no throttlelimit on this, use with caution.

# Usage example
(Measure-Command {
    1..100 | ParallelForEach { sleep 1; $_ }
}).TotalSeconds
