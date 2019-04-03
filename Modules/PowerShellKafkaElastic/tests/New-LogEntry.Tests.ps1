. "$PSScriptRoot\..\src\Public\New-LogEntry.ps1"

Describe "New-LogEntry" {

    It "Should return a json as string" {
        $test = New-LogEntry -action "Test" -status "OK" -description "testing" -timetaken 1000 
        $test_obj = $test | ConvertFrom-Json
        $test_obj.GetType().Name | Should Be 'PSCustomObject' 
    }
}