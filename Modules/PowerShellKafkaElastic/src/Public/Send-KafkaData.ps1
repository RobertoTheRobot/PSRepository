function Send-KafkaData {
    <# 
    .SYNOPSIS 
    Uses Confluence.Kafka library to send data to kafka 
    .DESCRIPTION 
    It uses a similar structure than the "beats" products by Elastic in order to send log entries to elasticsearch through kafka     
    .LINK 
    https://github.com/RobertoTheRobot
    #>
    [CmdletBinding()]
    Param(
    [Parameter (Mandatory = $true, ValueFromPipeline = $true, Position = 0)][String]$Server,
    [Parameter (Mandatory = $true, ValueFromPipeline = $true, Position = 1)][String]$Index,
    [Parameter (Mandatory = $true, ValueFromPipeline = $true, Position = 2)][String]$Topic,
    [Parameter (Mandatory = $true, ValueFromPipeline = $true, Position = 3)][String[]]$StringPayload
    )
    
    $UTF8 = [System.Text.Encoding]::UTF8
    
    # Configuration dictionary to be used for Kafka client
    $dict = New-Object "System.Collections.Generic.Dictionary[string,System.Object]"
    $dict["bootstrap.servers"] = $Server
    $producer = [Confluent.Kafka.Producer]::new($dict)
    
    $payloadArray = New-Object System.Collections.ArrayList
    
    #region Payload Object
    # Create json metadata and input message
    $stringPayload | ForEach-Object {
                        $payloadObject = New-Object System.Object
                        $payloadMessage = New-Object System.Object
                        $fieldsObject = New-Object System.Object
                        $fieldsObject | Add-Member -MemberType NoteProperty -Name "custom_index" -Value $index
                        $payloadObject | Add-Member -Name "message" -Value $_ -MemberType NoteProperty
                        $payloadObject | Add-Member -Name "fields" -Value $fieldsObject -MemberType NoteProperty 
                        $payloadObject | Add-Member -MemberType NoteProperty -Name "collection_timestamp" -Value ([System.DateTime]::Now.ToUniversalTime().ToString("yyyy-MM-dd'T'HH:mm:ss.fffZ"))
                        $json = $payloadObject | ConvertTo-Json -Compress
                        [Void]$payloadArray.Add($json)
                    }
    #endregion
    $payloadArray | ForEach-Object {
                        # Get bytes array for json in order to produce to Kafka
                        $bytes = $UTF8.GetBytes($_)
                        # produce to Kafka
                        [void]$producer.ProduceAsync($Topic,$null,$bytes)
                        Clear-Variable 'bytes'
                    }
    
    # Cleanup Kafka session
    $producer.Flush()
    $producer.Dispose()   
}