function Out-DataTable {  
    <# 
    .SYNOPSIS 
    Creates a DataTable for an object 
    .DESCRIPTION 
    Creates a DataTable based on an objects properties. 
    .INPUTS 
    Object 
        Any object can be piped to Out-DataTable 
    .OUTPUTS 
    System.Data.DataTable 
    .EXAMPLE 
    $dt = Get-psdrive| Out-DataTable 
    This example creates a DataTable from the properties of Get-psdrive and assigns output to $dt variable 
    .LINK 
    http://thepowershellguy.com/blogs/posh/archive/2007/01/21/powershell-gui-scripblock-monitor-script.aspx 
    #> 
    [CmdletBinding()] 
    param([Parameter(Position=0, Mandatory=$true, ValueFromPipeline = $true)] [PSObject[]]$InputObject) 
 
    Begin 
    { 
        $dt = new-object Data.datatable   
        $First = $true  
    } 
    Process 
    { 
        foreach ($object in $InputObject) 
        { 
            $DR = $DT.NewRow()   
            foreach($property in $object.PsObject.get_properties()) 
            {   
                if ($first) 
                {   
                    $Col =  new-object Data.DataColumn   
                    $Col.ColumnName = $property.Name.ToString()   
                    if ($property.value) 
                    {                         
                        if ($property.value -isnot [System.DBNull]) { 
                            if($property.TypeNameOfValue -eq 'Microsoft.ActiveDirectory.Management.ADPropertyValueCollection')
                            {
                                $Col.DataType = [System.Type]::GetType("System.String[]")
                            }
                            else
                            {
                                $Col.DataType = [System.Type]::GetType("$(Get-Type $property.TypeNameOfValue)") 
                            }
                         } 
                    } 
                    $DT.Columns.Add($Col) 
                }   
                if ($property.Gettype().IsArray) {                     
                    $DR.Item($property.Name) =$property.value | ConvertTo-XML -AS String -NoTypeInformation -Depth 1 
                }   
               elseif ($property.TypeNameOfValue -eq 'Microsoft.ActiveDirectory.Management.ADPropertyValueCollection') {
                    $DR.Item($property.Name) = [System.String[]]$property.value
               }
               else { 
                    $DR.Item($property.Name) = $property.value 
                } 
            }   
            $DT.Rows.Add($DR)   
            $First = $false 
        } 
    }  
      
    End 
    { 
        Write-Output @(,($dt)) 
    } 
}