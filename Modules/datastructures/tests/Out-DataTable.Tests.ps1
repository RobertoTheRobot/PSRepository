. "$PSScriptRoot\..\src\Public\Out-DataTable.ps1"

Describe "Out-DataTable" {
    It "transform collection to System.Data.DataTable" {
        $test_object = New-Object psobject -Property @{"prop1"="val1";"prop2"=10;}
        $test_collection = @() + $test_object + $test_object
        ($test_collection | Out-DataTable).GetType().Name | Should Be 'DataTable'
    }
}
