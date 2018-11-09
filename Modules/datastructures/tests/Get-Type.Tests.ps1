. "$PSScriptRoot\..\src\Private\Get-Type.ps1"

Describe "Get-Type" {
    It "return name of the [type] given" {
        $test_obj = 0
        Get-Type $test_obj | Should Be 'System.String' 
    }
}
