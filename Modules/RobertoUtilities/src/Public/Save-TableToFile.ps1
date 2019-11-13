Function Save-TableToFile {
    <# 
    .SYNOPSIS 
    Saves DataTable content to a file 
    .DESCRIPTION 
    Saves DataTable content to a file. 
    .INPUTS 
    datatable 
        System.Data.DataTable
    filePath
        string
    .OUTPUTS 
       Void 
    .EXAMPLE 
    $dt | Save-TableToFile -filePath "c:\file.ext"

    Save-TableToFile -dataTable $dt -filePath "c:\file.ext"    
    .LINK 
    https://github.com/RobertoTheRobot
    #> 
    param(
         [Parameter(Position=0, Mandatory=$true, ValueFromPipeline = $true)] [System.Data.DataTable]$datatable
        ,[Parameter(Position=1, Mandatory=$true, ValueFromPipeline = $false)][string]$filePath
    )

    Begin
    {
    }
    Process
    {
        $writer = New-Object IO.StreamWriter $filePath
        $datatable.WriteXml($writer, [Data.XmlWriteMode]::WriteSchema)
        $writer.Close()
        $writer.Dispose()
    }
    End
    {
    }
}