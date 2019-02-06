Sub Get_Data()
        Set objMyConn = New ADODB.Connection
        Set objMyRecordset1 = New ADODB.Recordset
        Dim strSQL As String

        objMyConn.ConnectionString = "Provider=SQLOLEDB;" & _
        "Data Source=10.0.18.3;" & _
        "Initial Catalog=ERBD_EGE_MAIN_17_Fresh_20170424;" & _
        "User ID=ra;" & _
        "Password=Njkmrjcdjb;"
        
        objMyConn.Open

        Dim lStr As String
        
        Dim strFilename As String: strFilename = "D:\query.sql"
        Dim strFileContent As String
        Dim iFile As Integer: iFile = FreeFile
        Open strFilename For Input As #iFile
        strFileContent = Input(LOF(iFile), iFile)
        Close #iFile
        
        Set objMyRecordset1.ActiveConnection = objMyConn
        objMyRecordset1.Open (strFileContent)
        
        Sheets(1).Range("A1").ClearContents
        Sheets(1).Range("A1").CopyFromRecordset (objMyRecordset1)

        objMyRecordset1.Close
        objMyConn.Close
        Set objMyConn = Nothing
End Sub
