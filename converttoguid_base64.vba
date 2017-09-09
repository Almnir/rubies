
Option Explicit

Private InitDone       As Boolean
Private Map1(0 To 63)  As Byte
Private Map2(0 To 127) As Byte

' Encodes a string into Base64 format.
' No blanks or line breaks are inserted.
' Parameters:
'   S         a String to be encoded.
' Returns:    a String with the Base64 encoded data.
Public Function Base64EncodeString(ByVal s As String) As String
   Base64EncodeString = Base64Encode(ConvertStringToBytes(s))
   End Function

' Encodes a byte array into Base64 format.
' No blanks or line breaks are inserted.
' Parameters:
'   InData    an array containing the data bytes to be encoded.
' Returns:    a string with the Base64 encoded data.
Public Function Base64Encode(InData() As Byte)
   Base64Encode = Base64Encode2(InData, UBound(InData) - LBound(InData) + 1)
   End Function

' Encodes a byte array into Base64 format.
' No blanks or line breaks are inserted.
' Parameters:
'   InData    an array containing the data bytes to be encoded.
'   InLen     number of bytes to process in InData.
' Returns:    a string with the Base64 encoded data.
Public Function Base64Encode2(InData() As Byte, ByVal InLen As Long) As String
   If Not InitDone Then Init
   If InLen = 0 Then Base64Encode2 = "": Exit Function
   Dim ODataLen As Long: ODataLen = (InLen * 4 + 2) \ 3     ' output length without padding
   Dim OLen As Long: OLen = ((InLen + 2) \ 3) * 4           ' output length including padding
   Dim Out() As Byte
   ReDim Out(0 To OLen - 1) As Byte
   Dim ip0 As Long: ip0 = LBound(InData)
   Dim ip As Long
   Dim op As Long
   Do While ip < InLen
      Dim i0 As Byte: i0 = InData(ip0 + ip): ip = ip + 1
      Dim i1 As Byte: If ip < InLen Then i1 = InData(ip0 + ip): ip = ip + 1 Else i1 = 0
      Dim i2 As Byte: If ip < InLen Then i2 = InData(ip0 + ip): ip = ip + 1 Else i2 = 0
      Dim o0 As Byte: o0 = i0 \ 4
      Dim o1 As Byte: o1 = ((i0 And 3) * &H10) Or (i1 \ &H10)
      Dim o2 As Byte: o2 = ((i1 And &HF) * 4) Or (i2 \ &H40)
      Dim o3 As Byte: o3 = i2 And &H3F
      Out(op) = Map1(o0): op = op + 1
      Out(op) = Map1(o1): op = op + 1
      Out(op) = IIf(op < ODataLen, Map1(o2), Asc("=")): op = op + 1
      Out(op) = IIf(op < ODataLen, Map1(o3), Asc("=")): op = op + 1
      Loop
   Base64Encode2 = ConvertBytesToString(Out)
   End Function

' Decodes a string from Base64 format.
' Parameters:
'    s        a Base64 String to be decoded.
' Returns     a String containing the decoded data.
Public Function Base64DecodeString(ByVal s As String) As String
   If s = "" Then Base64DecodeString = "": Exit Function
   Base64DecodeString = ConvertBytesToString(Base64Decode(s))
   End Function

' Decodes a byte array from Base64 format.
' Parameters
'   s         a Base64 String to be decoded.
' Returns:    an array containing the decoded data bytes.
Public Function Base64Decode(ByVal s As String) As Byte()
   If Not InitDone Then Init
   Dim IBuf() As Byte: IBuf = ConvertStringToBytes(s)
   Dim ILen As Long: ILen = UBound(IBuf) + 1
   If ILen Mod 4 <> 0 Then Err.Raise vbObjectError, , "Length of Base64 encoded input string is not a multiple of 4."
   Do While ILen > 0
      If IBuf(ILen - 1) <> Asc("=") Then Exit Do
      ILen = ILen - 1
      Loop
   Dim OLen As Long: OLen = (ILen * 3) \ 4
   Dim Out() As Byte
   ReDim Out(0 To OLen - 1) As Byte
   Dim ip As Long
   Dim op As Long
   Do While ip < ILen
      Dim i0 As Byte: i0 = IBuf(ip): ip = ip + 1
      Dim i1 As Byte: i1 = IBuf(ip): ip = ip + 1
      Dim i2 As Byte: If ip < ILen Then i2 = IBuf(ip): ip = ip + 1 Else i2 = Asc("A")
      Dim i3 As Byte: If ip < ILen Then i3 = IBuf(ip): ip = ip + 1 Else i3 = Asc("A")
      If i0 > 127 Or i1 > 127 Or i2 > 127 Or i3 > 127 Then _
         Err.Raise vbObjectError, , "Illegal character in Base64 encoded data."
      Dim b0 As Byte: b0 = Map2(i0)
      Dim b1 As Byte: b1 = Map2(i1)
      Dim b2 As Byte: b2 = Map2(i2)
      Dim b3 As Byte: b3 = Map2(i3)
      If b0 > 63 Or b1 > 63 Or b2 > 63 Or b3 > 63 Then _
         Err.Raise vbObjectError, , "Illegal character in Base64 encoded data."
      Dim o0 As Byte: o0 = (b0 * 4) Or (b1 \ &H10)
      Dim o1 As Byte: o1 = ((b1 And &HF) * &H10) Or (b2 \ 4)
      Dim o2 As Byte: o2 = ((b2 And 3) * &H40) Or b3
      Out(op) = o0: op = op + 1
      If op < OLen Then Out(op) = o1: op = op + 1
      If op < OLen Then Out(op) = o2: op = op + 1
      Loop
   Base64Decode = Out
   End Function

Private Sub Init()
   Dim c As Integer, i As Integer
   ' set Map1
   i = 0
   For c = Asc("A") To Asc("Z"): Map1(i) = c: i = i + 1: Next
   For c = Asc("a") To Asc("z"): Map1(i) = c: i = i + 1: Next
   For c = Asc("0") To Asc("9"): Map1(i) = c: i = i + 1: Next
   Map1(i) = Asc("+"): i = i + 1
   Map1(i) = Asc("/"): i = i + 1
   ' set Map2
   For i = 0 To 127: Map2(i) = 255: Next
   For i = 0 To 63: Map2(Map1(i)) = i: Next
   InitDone = True
   End Sub

Private Function ConvertStringToBytes(ByVal s As String) As Byte()
   Dim b1() As Byte: b1 = s
   Dim l As Long: l = (UBound(b1) + 1) \ 2
   If l = 0 Then ConvertStringToBytes = b1: Exit Function
   Dim b2() As Byte
   ReDim b2(0 To l - 1) As Byte
   Dim p As Long
   For p = 0 To l - 1
      Dim c As Long: c = b1(2 * p) + 256 * CLng(b1(2 * p + 1))
      If c >= 256 Then c = Asc("?")
      b2(p) = c
      Next
   ConvertStringToBytes = b2
   End Function

Private Function ConvertBytesToString(b() As Byte) As String
   Dim l As Long: l = UBound(b) - LBound(b) + 1
   Dim b2() As Byte
   ReDim b2(0 To (2 * l) - 1) As Byte
   Dim p0 As Long: p0 = LBound(b)
   Dim p As Long
   For p = 0 To l - 1: b2(2 * p) = b(p0 + p): Next
   Dim s As String: s = b2
   ConvertBytesToString = s
   End Function
Public Sub test_enc_dec()
'Debug.Print Base64EncodeString("sdsd")
'Debug.Print Base64EncodeString("c2RzZA==")
Debug.Print GetHash("5600000000")
Debug.Print Base64DecodeString("NTY=")
End Sub
Function GetHash(ByVal txt$) As String
    Call Init
    Dim oUTF8, oMD5, abyt, i&, k&, hi&, lo&, chHi$, chLo$
    Set oUTF8 = CreateObject("System.Text.UTF8Encoding")
    abyt = Base64EncodeString(oUTF8.GetBytes_4(txt$))
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
    columnIndex = Range(columnName & 1).column
    Dim maxRow As Long
    maxRow = ActiveSheet.Cells(ActiveSheet.Rows.Count, columnName).End(xlUp).Row
    Dim i As Long
    For i = 6 To maxRow
       Dim strCell As String
       strCell = GetHash(Cells(i, columnIndex).value)
       Cells(i, columnIndex).value = HashToGuid(strCell)
    Next i
End Sub

