# A script to kill processes that have files open in the current working directory (recursively)
#
# It does this by using [handle](https://docs.microsoft.com/en-us/sysinternals/downloads/handle)
# to find all processes of a particular name which have file locks on our build (project) directory.
# We can then attempt to kill each of these processes if any exist.
#
# The expected usage is as follows:
#   powershell -NoProfile -NonInteractive purge.ps1 MyApp.exe,BuildTool.exe
param(
  [String] $Dir = $(pwd).Path,
  [String[]] $processes
)

echo "Running in directory: $Dir"

function Kill-Dangling-Processes {
	param( [string]$ProcessName )

	echo "Looking for ${ProcessName} processes to kill..."
	$Out=$(handle64 -accepteula -nobanner -p "$($ProcessName)" $Dir)
  echo $Out
	ForEach ($line in $($OUT -split "`r`n"))
	{
		$Result = $([regex]::Match("$line", "pid: (.*) type"))
		if ($Result.Success)
		{
			$ppid = $Result.Groups[1].Value
			taskkill /f /t /pid $ppid
		}
	}
}

ForEach ($Process in $processes)
{
	Kill-Dangling-Processes $Process
}
