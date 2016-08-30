Attribute VB_Name = "Compute"
Sub UploadQuantity()

yahoo6digit.Activate

Application.ScreenUpdating = False


Dim colAbstract As Integer, colQuantity As Integer, colAllow As Integer, colStatus As Integer

colAbstract = yahoo6digit.Rows(1).Find("abstract").Column

On Error Resume Next
    colQuantity = yahoo6digit.Rows(1).Find("quantity").Column
    colAllow = yahoo6digit.Rows(1).Find("allow-overdraft").Column
    colStatus = yahoo6digit.Rows(1).Find("status").Column

    If Err Then
    
        'ヘッダーがなければ追記
        yahoo6digit.Range("A1").End(xlToRight).Offset(0, 1).Resize(1, 3) = Array("quantity", "allow-overdraft", "status")
        Err.Clear
    
    End If
    
On Error GoTo 0

Dim r As Range

With yahoo6digit 'With構文内ではオブジェクト参照が繰り返されないため、少しだけ高速になるらしい

    For Each r In .Range("YahooCodeRange")
        
        '在庫設定除外シートにあれば、以下の処理は行わない、Continueへ飛ぶ
        If WorksheetFunction.CountIf(ExceptQty.Range("ExceptCodeRange"), r.Value) > 0 Then GoTo Continue
       
        Dim i As Long
        i = r.Row

        'Itemオブジェクトを生成
        
        Dim YahooItem As Object
        Set YahooItem = New Item
        
        Call YahooItem.Constractor(r.Value, .Cells(i, colAbstract).Value)
        
        'シートへ書き込み
       
        .Cells(i, colQuantity).Value = YahooItem.GetQuantity
        
        If YahooItem.GetAvailablePurchase Then  'AvailablePurchaseはBool値なので1/0に置き換えて出力
            .Cells(i, colAllow).Value = 1
        Else
            .Cells(i, colAllow).Value = 0
        End If
               
        .Cells(i, colStatus).Value = YahooItem.status
       
Continue:
    
       Set Item = Nothing
       
    Next r

End With

End Sub
