#Set vars
$myDirectory = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
$filepath = $myDirectory + "\file.xlsx"
$SheetName = "Feuil1"



#set excel variable (with param)
$objExcel = New-Object -ComObject Excel.Application
$objExcel.Visible = $true
$objExcel.DisplayAlerts = $false;


$WorkBook = $objExcel.Workbooks.Open($filepath)
$workSheet = $WorkBook.sheets($SheetName)

#delete filter in worksheet
$workSheet.autofiltermode=$false



#know number of line and column used
$workSheet_used_range = $workSheet.UsedRange
$RowCount = $workSheet_used_range.Rows.Count
$ColumnCount = $workSheet_used_range.Columns.Count
$last_column_letter = $(Convert-NumberToA1 -number $ColumnCount)
$full_header_range_of_report = "A1:" + $(Convert-NumberToA1 -number $ColumnCount) + "1"
Write-Host "RowCount : " $RowCount
Write-Host "ColumnCount : " $ColumnCount
Write-Host "Header range (1st line) : " $full_header_range_of_report


#find the colum of "something" (replace the range with format : range(A1:A12) )
$getName = $workSheet.Range($full_header_range_of_report).find("something")
$column_number_of_something = $getName.column
$column_letter_of_something = Convert-NumberToA1 -number $column_number_of_something
Write-Host "column of something" $column_letter_of_something


#get value of range in excel and set in powershell array
$Column1="1"
$Column2="2"

$array = @()
$workSheet_used_range = $workSheet.UsedRange
$RowCount = $workSheet_used_range.Rows.Count
for($i=2 ;$i -le $RowCount ; $i++){
    $array += [pscustomobject]@{Colum1=$($workSheet.Cells.item($i,$Column1).text);Column2=$($workSheet.Cells.item($i,$Column2).text)}  
}
Write-Host $array



$WorkBook.close($false)
$objExcel.Quit()



#function to convert number to letter of alphabet
Function Convert-NumberToA1 { 
  <#
  .SYNOPSIS
  This converts a column number into A1 format.
  .DESCRIPTION
  See synopsis.
  .PARAMETER number
  The number to be converted into A1 format
  #> 
 
  Param([parameter(Mandatory=$true)]
        [decimal]$number)
 
  $number = $number -replace "\..*",""
  $a1Value = $null
  While ($number -gt 0) {
    [decimal]$multiplier = [system.math]::Floor(($number / 26))
    [int]$charNumber = $number - ($multiplier * 26)
    If ($charNumber -eq 0) { $multiplier-- ; $charNumber = 26 }
    $a1Value = [char]($charNumber + 64) + $a1Value
    $number = $multiplier
  }
  Return $a1Value
}