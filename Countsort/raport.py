import os,linecache
fi=open('.\\raport\\raport.html','w')
fi.write("""<HTML>
<HEAD>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Counting Sort</title> <link rel="stylesheet" href="style.css"></HEAD>
<BODY><table align=center><tr><td>Czas wykonania[ms]</td><td>Posegregowany ciag</td></tr>""")
for files in os.walk('.\\output\\'):
    for infile in files[2]:
        inpt=open('.\\output\\'+infile,'r')
        countline=len(inpt.readlines())
        fi.write("""<tr><td>""")
        time=linecache.getline('.\\output\\'+infile,1)
        fi.write(time)
        fi.write("""</td><td>""")
        for x in range(2,countline):
            line=linecache.getline('.\\output\\'+infile,x)
            fi.write(line+""" """)
        fi.write("""</td></tr>"""+'\n')
        inpt.close()
fi.write("""</table></BODY></HTML>""")
fi.close()
        
