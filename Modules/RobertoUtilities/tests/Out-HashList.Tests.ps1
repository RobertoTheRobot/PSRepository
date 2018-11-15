. "$PSScriptRoot\..\src\Public\Out-HashList.ps1"

Describe "Out-HashList" {
    It "transform collection to System.Data.DataTable" {
        $test_object = New-Object psobject -Property @{"prop1"="val1";"prop2"=10;}
        $test_collection = @() + $test_object + $test_object
        ($test_collection | Out-HashList -key 'prop1' -value 'prop2').GetType().Name | Should Be 'Hashtable'
    }
}