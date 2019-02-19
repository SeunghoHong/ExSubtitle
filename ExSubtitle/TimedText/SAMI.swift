
/*
 * https://en.wikipedia.org/wiki/SAMI
 * application/smil+xml

<SAMI>
  <HEAD>
    <TITLE>SAMI Example</TITLE>
    <SAMIParam>
      Media {cheap44.wav}
      Metrics {time:ms;}
      Spec {MSFT:1.0;}
    </SAMIParam>
    <STYLE TYPE="text/css">
    <!--
    P { font-family: Arial; font-weight: normal; color: white; background-color: black; text-align: center; }
    #Source {color: red; background-color: blue; font-family: Courier; font-size: 12pt; font-weight: normal; text-align: left; }
    .ENUSCC { name: English; lang: en-US ; SAMIType: CC ; }
    .FRFRCC { name: French;  lang: fr-FR ; SAMIType: CC ; }
    -->
    </STYLE>
  </HEAD>
  <BODY>
    <SYNC Start=0>
      <P Class=ENUSCC ID=Source>The Speaker</P>
      <P Class=ENUSCC>SAMI 0000 text</P>
      <P Class=FRFRCC ID=Source>French The Speaker</P>
      <P Class=FRFRCC>French SAMI 0000 text</P>
    </SYNC>
    <SYNC Start=1000>
      <P Class=ENUSCC>SAMI 1000 text</P>
      <P Class=FRFRCC>French SAMI 1000 text</P>
    </SYNC>
    <SYNC Start=2000>
      <P Class=ENUSCC>SAMI 2000 text</P>
      <P Class=FRFRCC>French SAMI 2000 text</P>
    </SYNC>
  </BODY>
</SAMI>

 */
