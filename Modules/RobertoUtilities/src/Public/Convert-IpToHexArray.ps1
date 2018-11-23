function Convert-IpToHexArray {
    param([Parameter(Position=0, Mandatory=$true, ValueFromPipeline = $true)] [string] $ip) 

    $ipArray = $ip.ToCharArray()
    $hexArr=@()

    $ipArray | % { $hexArr += "0x" + [Convert]::ToString([byte][char]$_,16) }

    $hexArr
}