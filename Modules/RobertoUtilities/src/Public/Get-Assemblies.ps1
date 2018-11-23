function Get-Assemblies {
    param(
        [Parameter(Position=0, Mandatory=$false, ValueFromPipeline = $false)] [string] $Match,
        [Parameter(Position=1, Mandatory=$false, ValueFromPipeline = $false)] [Switch]$NamesOnly
    ) 
	$matchingAsms = [Threading.Thread]::GetDomain().GetAssemblies() | Where-Object { $_.Location -match $Match }
	
	if($NamesOnly.IsPresent) {
		$matchingAsms | Select-Object @{Name="Name"; Expression={ (Get-ChildItem $_.Location).Name }}
	}
	else {
		$matchingAsms
	}
}