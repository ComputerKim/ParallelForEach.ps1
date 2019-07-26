function ParallelForEach {
    param([scriptblock]$Process, [parameter(ValueFromPipeline)]$InputObject)
    $runspaces = $Input | ForEach {
        $r = [PowerShell]::Create().AddScript("param(`$_);$Process").AddArgument($_)
        [PSCustomObject]@{ Runspace = $r; Handle = $r.BeginInvoke() }
    }
    $runspaces | ForEach { 
        while (!$_.Handle.IsCompleted) { sleep -m 100 }
        $_.Runspace.EndInvoke($_.Handle)
    }
}