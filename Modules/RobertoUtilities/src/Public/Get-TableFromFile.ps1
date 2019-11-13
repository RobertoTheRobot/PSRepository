Function Get-TableFromFile {
    <# 
    .SYNOPSIS 
    Get content of a Datatable from file 
    .DESCRIPTION 
    Get content of a Datatable from file. 
    .INPUTS 
    filePath
        string
    .OUTPUTS 
       System.Data.DataTable 
    .EXAMPLE 
    $dt = Get-TableFromFile -filePath C:\file.ext
    .LINK 
    https://github.com/RobertoTheRobot
    #>
    param(
         [Parameter(Position=0, Mandatory=$true, ValueFromPipeline = $false)][string]$filePath
    )

    Begin
    {
        $ds = New-Object Data.DataSet
    }
    Process
    {
        [void]$ds.ReadXml($filePath, [Data.XmlReadMode]::ReadSchema)
    }
    End
    {
        return $ds.Tables[0]
    } 
}