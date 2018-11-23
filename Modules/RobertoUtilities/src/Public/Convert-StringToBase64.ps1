function Convert-StringToBase64 {
    param([Parameter(Position=0, Mandatory=$true, ValueFromPipeline = $true)] [string] $str) 
    [System.Convert]::ToBase64String([system.Text.Encoding]::UTF8.GetBytes($str))
}