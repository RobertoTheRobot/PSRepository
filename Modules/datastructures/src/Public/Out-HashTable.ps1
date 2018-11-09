Function Out-HashTable {
    <# 
    .SYNOPSIS 
    Creates a HashTable 
    .DESCRIPTION 
    Creates a HashTable based on a collection of objects using obj properties as key / value.
    .INPUTS 
    Object 
        Any object collection can be piped to Out-HashList 
    .OUTPUTS 
    System.Data.HashTable 
    .EXAMPLE 
    $ht = Get-psdrive | Out-HashTable -key Name -value Root
    This example creates a HashTable which keys are the name of the drive and value the root.     
    #>
    param(
     [Parameter(Position=0, Mandatory=$true, ValueFromPipeline = $true)] [PSObject[]]$collection
    ,[Parameter(Position=1, Mandatory=$true, ValueFromPipeline = $false)][string]$key
    ,[Parameter(Position=2, Mandatory=$true, ValueFromPipeline = $false)][string]$value
    )

    Begin
    {
        $hashTable = @{}
    }
    Process
    {
        foreach($item in $collection)
        {
            $hashTable[$item.($key)] = $item.($value)
        }
    }
    End
    {
        return $hashTable
    }
}