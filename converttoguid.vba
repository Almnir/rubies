' Скрипт для конвертации ID в GUID
' (с) ФГБУ ФЦТ 2017
Option Explicit

Function GetHash(ByVal txt$) As String
    Dim oUTF8, oMD5, abyt, i&, k&, hi&, lo&, chHi$, chLo$
    Set oUTF8 = CreateObject("System.Text.UTF8Encoding")
    Set oMD5 = CreateObject("System.Security.Cryptography.MD5CryptoServiceProvider")
    abyt = oMD5.ComputeHash_2(oUTF8.GetBytes_4(txt$))
    For i = 1 To LenB(abyt)
        k = AscB(MidB(abyt, i, 1))
        lo = k Mod 16: hi = (k - lo) / 16
        If hi > 9 Then chHi = Chr(Asc("a") + hi - 10) Else chHi = Chr(Asc("0") + hi)
        If lo > 9 Then chLo = Chr(Asc("a") + lo - 10) Else chLo = Chr(Asc("0") + lo)
        GetHash = GetHash & chHi & chLo
    Next
    Set oUTF8 = Nothing: Set oMD5 = Nothing
End Function

Function HashToGuid(ByVal strInput As String) As String
   HashToGuid = Mid$(strInput, 1, 8) + "-" + Mid$(strInput, 9, 4) + "-" + Mid$(strInput, 13, 4) + "-" + Mid$(strInput, 17, 4) + "-" + Mid$(strInput, 21)
End Function


Sub ConvertToGuid()
    Dim columns As Variant
    columns = Array("A", "B")
    Dim column As Variant
    For Each column In columns
        ConvertColumn (column)
    Next column
End Sub

Sub ConvertColumn(columnName As String)
    Dim columnIndex As Integer
    columnIndex = range(columnName & 1).column
    Dim maxRow As Long
    maxRow = ActiveSheet.Cells(ActiveSheet.Rows.count, columnName).End(xlUp).row
    Dim i As Long
    For i = 6 To maxRow
       Dim strCell As String
       strCell = GetHash(Cells(i, columnIndex).Value)
       Cells(i, columnIndex).Value = HashToGuid(strCell)
    Next i
End Sub




