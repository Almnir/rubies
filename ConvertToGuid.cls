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

Sub ConvertColumn(columnName As Variant, rowStart as Long)
    Dim columnIndex As Integer
    columnIndex = Range(columnName & 1).column
    Dim maxRow As Long
    maxRow = ActiveSheet.Cells(ActiveSheet.Rows.Count, columnName).End(xlUp).Row
    Dim i As Long
    For i = rowStart To maxRow
       Dim strCell As String
       strCell = UCase(GetHash(Cells(i, columnIndex).Value))
       Cells(i, columnIndex).Value = HashToGuid(strCell)
    Next i
End Sub

Sub ConvertToGuid()
    Dim columns As Variant
    ' Массив столбцов, которые содержат ID для преобразования в GUID
    columns = Array("A", "B")
    Dim rowStart As Long
    ' Стартовая строка с данными (в разных таблицах первая значащая строка различается по индексу)
    ' Например в rbd_CurrentRegion.xlsx ID начинается с A6, соответственно rowStart = 6
    rowStart = 6
    Dim column As Variant
    For Each column In columns
        Call ConvertColumn (column, rowStart)
    Next column
End Sub