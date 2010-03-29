; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{0A22D345-DFA9-45B8-AC92-57F2E933BA7D})
AppName=Short Attention Span Docbook
AppVerName=Short Attention Span Docbook 1.2.1
AppPublisher=New Auburn Personal Computer Services LLC
AppPublisherURL=http://www.napcs.com
AppSupportURL=http://www.napcs.com
AppUpdatesURL=http://www.napcs.com/products/docbook
DefaultDirName=c:\docbook
DefaultGroupName=Short Attention Span Docbook
AllowNoIcons=yes
OutputBaseFilename=docbook_setup-1_2_1
Compression=lzma
SolidCompression=yes
ChangesEnvironment=yes
InfoBeforeFile=requirements.txt

        
[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "jars\*"; DestDir: "{app}\jars"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "lib\*"; DestDir: "{app}\lib"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "template\*"; DestDir: "{app}\template"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "xsl\*"; DestDir: "{app}\xsl"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "generate"; DestDir: "{app}"; Flags: ignoreversion
Source: "make.rb"; DestDir: "{app}"; Flags: ignoreversion
Source: "Rakefile"; DestDir: "{app}"; Flags: ignoreversion
Source: "README.txt"; DestDir: "{app}"; Flags: ignoreversion

Source: "generate.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "requirements.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "version.rb"; DestDir: "{app}"; Flags: ignoreversion
Source: "readme_files\docbook.pdf"; DestDir: "{app}"; Flags: ignoreversion
Source: "hhc.exe"; DestDir: "{app}"; Flags: ignoreversion
;Source: "xsltproc\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{cm:UninstallProgram,Short Attention Span Docbook}"; Filename: "{uninstallexe}"
Name: "{group}\Getting Started"; Filename: "{app}\docbook.pdf"

[Registry]

Root: HKCU; Subkey: "Environment"; ValueType: string; ValueName: "SHORT_ATTENTION_SPAN_DOCBOOK_PATH"; ValueData: """{app}"""; Flags: uninsdeletevalue

[Tasks]
Name: modifypath; Description: Add application directory to your system path;

[Code]
function ModPathDir(): TArrayOfString;
var
    Dir: TArrayOfString;
begin
    setArrayLength(Dir, 1)
    Dir[0] := ExpandConstant('{app}');
    Result := Dir;
end;
#include "modpath.iss"

