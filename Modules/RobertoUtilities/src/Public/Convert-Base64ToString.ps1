function Convert-StringFromBase64 {
    param([Parameter(Position=0, Mandatory=$true, ValueFromPipeline = $true)] [string] $str) 
    [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($str))
}