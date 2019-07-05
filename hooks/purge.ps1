# A script to kill processes that have files open in the current working directory (recursively)
#
# It does this by using [handle](https://docs.microsoft.com/en-us/sysinternals/downloads/handle)
# to find all processes of a particular name which have file locks on our build (project) directory.
# We can then attempt to kill each of these processes if any exist.
#
# The expected usage is as follows:
#   powershell -NoProfile -NonInteractive purge.ps1 -Dir C:\my-directory
param(
  [String] $Dir = $(pwd).Path,
  [String[]] $Whitelist = ('explorer.exe', 'handle64.exe')
)

pslist -t -accepteula -nobanner

"Finding handles in $Dir"
$OUT=$(handle64 -accepteula -nobanner $Dir)

$processMap = @{}
ForEach ($line in $OUT -split "`r`n")
{
	$Result = $([regex]::Match("$line", "(.*?)\s+pid: (.*) type"))
	if ($Result.Success)
	{
		$image = $Result.Groups[1].Value
		$ppid = $Result.Groups[2].Value
		$processMap.$ppid = $image
	}
}

if ($processMap.Count -eq 0)
{
    "No handles found."
}
else
{
	$processMap | Format-Table

	"Whitelisted: $Whitelist"
	foreach($ppid in $processMap.keys)
	{
		$imageName = $processMap.$ppid
		if (! $Whitelist.Contains($imageName)){
			"Killing $ppid"
			taskkill /f /t /pid $ppid
		}
	}
}
