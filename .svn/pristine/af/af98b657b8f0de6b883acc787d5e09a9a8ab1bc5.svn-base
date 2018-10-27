<script language="vbscript" runat="server">
'  copyright 2001, E Michael Brandt of www.valleywebdesigns.com.
'  based on a script by, and used with the permission of, Mike Shaffer, whose site - www.effengud.com - you should certainly visit.
'  ALL RIGHTS RESERVED WORLDWIDE
'  version 1.0.2

function vwdImageBounds(flnm,maxWidth,maxHeight)
	Dim width
	Dim height
	Dim imgAspectRatio
	Dim deltaWidth
	Dim deltaHeight
	if gfxSpex(flnm, width, height) = False then 
		width=0
		height=0
	end if
	if width > 0 AND height > 0 then
		ori_width=width
		ori_height=height
		imgAspectRatio=width/height
		'deltaWidth=maxWidth - width
		'deltaHeight=maxHeight - height
		'if deltaWidth > deltaHeight then
		'	height=maxHeight
		'	width=int(height * imgAspectRatio)
		'else
		'	width=maxWidth
		'	height=int(width*(1/imgAspectRatio))
		'end if
		
		'Vicente
		if width>maxWidth then
			width=maxWidth
			height=int(width/imgAspectRatio)
		end if
		if height>MaxHeight then
			height=MaxHeight
			width=int(height*imgAspectRatio)
		end if
	end if
	vwdImageBounds="width=" & chr(34) & cStr(width) & chr(34) & " height=" & chr(34) & cStr(height) & chr(34)
end function	
 
function GetBytes(flnm, offset, bytes)
     Dim objFSO
     Dim objFTemp
     Dim objTextStream
     Dim lngSize

     on error resume next
     Set objFSO = CreateObject("Scripting.FileSystemObject")
	 flnm=Server.MapPath(flnm)
	
     ' First, we get the filesize
     Set objFTemp = objFSO.GetFile(flnm)
     lngSize = objFTemp.Size
     set objFTemp = nothing

     fsoForReading = 1
     Set objTextStream = objFSO.OpenTextFile(flnm, fsoForReading)
     if offset > 0 then
        strBuff = objTextStream.Read(offset - 1)
     end if

     if bytes = -1 then
        GetBytes = objTextStream.Read(lngSize)  'ReadAll
     else
        GetBytes = objTextStream.Read(bytes)
     end if

     objTextStream.Close
     set objTextStream = nothing
     set objFSO = nothing
end function

function lngConvert(strTemp)
    lngConvert = clng(asc(left(strTemp, 1)) + ((asc(right(strTemp, 1)) * 256)))
end function

function lngConvert2(strTemp)
     lngConvert2 = (asc(right(strTemp, 1)) + ((asc(left(strTemp, 1)) * 256)))
end function
 
function gfxSpex(flnm, width, height)

     dim strPNG 
     dim strGIF
     dim strBMP
     dim strType
     strType = ""
     gfxSpex = False

     strPNG = chr(137) & chr(80) & chr(78)
     strGIF = "GIF"
     strType = GetBytes(flnm, 0, 3)
     if strType = strGIF then
        width = lngConvert(GetBytes(flnm, 7, 2))
        height = lngConvert(GetBytes(flnm, 9, 2))
        gfxSpex = True

     elseif left(strType, 2) = strBMP then	
		'never a bmp
		
     elseif strType = strPNG then
        Width = lngConvert2(GetBytes(flnm, 19, 2))
        Height = lngConvert2(GetBytes(flnm, 23, 2))
        Depth = getBytes(flnm, 25, 2)
	
		Dim d
		d=asc(right(Depth,1))
		if d=0 OR d=2 OR d=3 OR d=4 OR d=6 then gfxSpex=True

     else
        strBuff = GetBytes(flnm, 0, -1)	
        lngSize = len(strBuff)
        flgFound = 0

        strTarget = chr(255) & chr(216) & chr(255)
        flgFound = instr(strBuff, strTarget)

        if flgFound = 0 then
           exit function
        end if

        lngPos = flgFound + 2 'jpg
        ExitLoop = false

        do while ExitLoop = False and lngPos < lngSize

           do while asc(mid(strBuff, lngPos, 1)) = 255 and lngPos < lngSize
              lngPos = lngPos + 1
           loop

           if asc(mid(strBuff, lngPos, 1)) < 192 or asc(mid(strBuff, lngPos, 1)) > 195 then
              lngMarkerSize = lngConvert2(mid(strBuff, lngPos + 1, 2))
              lngPos = lngPos + lngMarkerSize  + 1
           else
              ExitLoop = True
           end if

       loop
       if ExitLoop = False then
          Width = -1
          Height = -1
       else
          Height = lngConvert2(mid(strBuff, lngPos + 4, 2))
          Width = lngConvert2(mid(strBuff, lngPos + 6, 2))
          gfxSpex = True
       end if
                   
     end if

end function

</script>
