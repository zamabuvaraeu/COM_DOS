Option Explicit

Dim FSO
Set FSO = CreateObject("Scripting.FileSystemObject")

Dim TextStream


Set TextStream = FSO.OpenTextFile(WScript.Arguments(0), 1)

Dim Lines
Lines = TextStream.ReadAll

TextStream.Close
Set TextStream = Nothing

Dim LinesArray
LinesArray = Split(Lines, vbCrLf)

Dim i
For i = 0 To UBound(LinesArray)
	
	Select Case LinesArray(i)
		
		Case "int32 memcmp( void*, void*, uint64 );"
			LinesArray(i) = "int32 memcmp( const void*, const void*, uint64 );"
		
		Case "void* memcpy( void*, void*, uint64 );"
			LinesArray(i) = "void* memcpy( void*, const void*, uint64 );"
			
		Case "void* memmove( void*, void*, uint64 );"
			LinesArray(i) = "void* memmove( void*, const void*, uint64 );"
		
		Case "int64 _InterlockedExchangeAdd64( int64*, int64 );"
			LinesArray(i) = "int64 _InterlockedExchangeAdd64( volatile int64*, int64 );"
		
		Case "int32 _InterlockedExchangeAdd( int32*, int32 );"
			LinesArray(i) = "long _InterlockedExchangeAdd( volatile long*, long );"
			
	End Select
	
	If InStr(LinesArray(i), "@llvm.global_ctors = ") Then
		LinesArray(i) = "; " & LinesArray(i)
	End If
	
	If InStr(LinesArray(i), "__builtin_memset( &fb$result$1") Then
		LinesArray(i) = "/* " & LinesArray(i) & " */"
	End If
	
Next

Lines = Join(LinesArray, vbCrLf)

Set TextStream = FSO.OpenTextFile(WScript.Arguments(0), 2)

TextStream.WriteLine Lines

TextStream.Close
Set TextStream = Nothing


Set FSO = Nothing
