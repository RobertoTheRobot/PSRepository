Function New-LogEntry {
    <# 
    .SYNOPSIS 
    Create a standard object for logging in order to be sent to Kafka and later indexed in elasticsearch 
    .DESCRIPTION 
    Create a standard object for logging in order to be sent to Kafka and later indexed in elasticsearch 
    .LINK 
    https://github.com/RobertoTheRobot
    #>
    [CmdletBinding()]
    param(
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline = $false)][string]$action,
        [ValidateSet('OK','INFO','WARNING','ERROR')] 
        [Parameter(Position=1, Mandatory=$true, ValueFromPipeline = $false)][string]$status,
        [Parameter(Position=2, Mandatory=$true, ValueFromPipeline = $false)][string]$description, 
        [Parameter(Position=03, Mandatory=$false, ValueFromPipeline = $false)][long]$timetaken
    )

    $logLine = New-Object psobject
    $logLine | Add-Member NoteProperty 'timestamp' (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")
    $logLine | Add-Member NoteProperty 'host' $env:COMPUTERNAME
    $logLine | Add-Member NoteProperty 'script' $MyInvocation.MyCommand.Name
    $logLine | Add-Member NoteProperty 'path' $MyInvocation.MyCommand.Path
    $logLine | Add-Member NoteProperty 'action' $action
    $logLine | Add-Member NoteProperty 'status' $status
    $logLine | Add-Member NoteProperty 'description' $description  
    $logLine | Add-Member NoteProperty 'timetaken' $timetaken   

    return ($logLine | ConvertTo-Json -Compress)
}