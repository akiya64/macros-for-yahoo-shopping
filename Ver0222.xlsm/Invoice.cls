VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Invoice"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'送り状1個のクラス

Public Id As String
Public InvoiceNumber As String
Public ShippingDate As Date
Public ShippingMethod As String

