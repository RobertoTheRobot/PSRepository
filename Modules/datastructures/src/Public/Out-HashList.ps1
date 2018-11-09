Function Out-HashList {
    <# 
    .SYNOPSIS 
    Creates a HashTable 
    .DESCRIPTION 
    Creates a HashTable based on a collection of objects using obj properties as key / value. The Value in the hash is an arraylist 
    .INPUTS 
    Object 
        Any object collection can be piped to Out-HashList 
    .OUTPUTS 
    System.Data.HashTable 
    .EXAMPLE 
    $hl = Get-ADUser -filter {Enabled -eq $true} -properties department | Out-HashList -key department -value samaccountname
    This example creates a HashTable which keys are department and value a list of samaccountname     
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
            if(!$hashTable[$item.($key)])
            {
                $hashTable[$item.($key)] = New-Object System.Collections.ArrayList
            }            
            [void]$hashTable[$item.($key)].Add($item.($value))
        }
    }
    End
    {
        return $hashTable
    }
}