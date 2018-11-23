Function QueryTo-MySQLDB {
    [CmdletBinding()] 
    param(        
        [Parameter(Position=0, Mandatory=$true)][string]$MySQLHost,
        [Parameter(Position=0, Mandatory=$true)][string]$MySQLDatabase,
        [Parameter(Position=1, Mandatory=$true)][string]$MySQLQuery,
        [Parameter(Position=2, Mandatory=$true)][pscredential]$Credentials
    )
    Begin {
        $MySQLAdminUserName = $Credentials.UserName
        $MySQLAdminPassword = $Credentials.GetNetworkCredential().Password    
        $ConnectionString = "server=" + $MySQLHost + ";port=3306;uid=" + $MySQLAdminUserName + ";pwd=" + $MySQLAdminPassword + ";database="+$MySQLDatabase
    }
    Process {
        [void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
        $Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
        $Connection.ConnectionString = $ConnectionString
        $Connection.Open()
        $Command = New-Object MySql.Data.MySqlClient.MySqlCommand ($MySQLQuery, $Connection)
        $DataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter ($Command)
        $DataSet = New-Object System.Data.DataSet
        [void]$dataAdapter.Fill( $dataSet)
        $Connection.Close() 
    }
    End {
        return $DataSet
    }
}