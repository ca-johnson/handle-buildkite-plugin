# A script to kill processes that have files open in the current working directory (recursively)
#
# It does this by using [handle](https://docs.microsoft.com/en-us/sysinternals/downloads/handle)
# to find all processes of a particular name which have file locks on our build (project) directory.
# We can then attempt to kill each of these processes if any exist.
#
# The expected usage is as follows:
#   powershell -NoProfile -NonInteractive purge.ps1 MyApp.exe,BuildTool.exe
param(
  [String[]] $processes
)

echo "Running in directory: $(pwd)"

function Kill-Dangling-Processes {
	param( [string]$ProcessName )

	echo "Looking for ${ProcessName} processes to kill..."
	$Dir=$(pwd).Path
	$Out=$(handle64 -accepteula -p "$($ProcessName).exe" $Dir)
	ForEach ($line in $($OUT -split "`r`n"))
	{
		$Result = $([regex]::Match("$line", "pid: (.*) type"))
		if ($Result.Success)
		{
			$ppid = $Result.Groups[1].Value
			taskkill /f /pid $ppid
		}
	}
}

ForEach ($Process in $processes)
{
	Kill-Dangling-Processes $Process
}
