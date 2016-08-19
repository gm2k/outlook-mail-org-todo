VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisOutlookSession"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True

Sub AddLinkToMessageInClipboard()
    
    Dim orgFile As String
    Dim orgTag As String
    orgFile = "D:\Dropbox\org\my.org.txt"
    orgTag = ":WORK:"
    'MsgBox ("start")
    Dim objMail As Outlook.MailItem
    
    If Application.ActiveExplorer.Selection.Count <> 1 Then
        MsgBox ("Select one and ONLY one message.")
        Exit Sub
    End If

    Set objMail = Application.ActiveExplorer.Selection.Item(1)
    Dim mytext As String
    mytext = vbLf + "** TODO [[outlook:" + objMail.EntryID + "][MESSAGE: " + Replace(Replace(objMail.Subject, "[", "("), "]", ")") + " (" + objMail.SenderName + ")]]   " + orgTag + vbLf
    'MsgBox (mytext)
    ' hook to create file if not exists
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    If Not objFSO.FileExists(orgFile) Then
        Set objFile = objFSO.CreateTextFile(orgFile)
        objFile.Close
        
    End If
    'MsgBox ("create")

   
    'append
    Dim fsT As Object
    
    Set fsT = CreateObject("ADODB.Stream")
    fsT.Type = 2
    fsT.Charset = "utf-8"
    fsT.Open
    'MsgBox ("open")
    myx = ""
    fsT.LoadFromFile (orgFile)
    myx = fsT.ReadText(-1)
    mytext = myx & mytext
    'MsgBox ("append")
    fsT.WriteText mytext
    fsT.SaveToFile orgFile, 2
    'MsgBox ("save")
    fsT.Close
End Sub

