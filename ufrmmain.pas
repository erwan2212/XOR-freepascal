unit ufrmmain;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils,  Dialogs, StdCtrls, Classes, Controls,
  ComCtrls,  Graphics,  Forms  ;

type
  TfrmMain = class(TForm)
    OpenDialog1: TOpenDialog;
    txtdecoded: TEdit;
    Button6: TButton;
    Button7: TButton;
    txtencoded: TEdit;
    Button1: TButton;
    Button2: TButton;
    txtkey1: TEdit;
    Label1: TLabel;
    txtkey2: TEdit;
    txtkey3: TEdit;

    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;


implementation

uses uXOR;

{$R *.lfm}

procedure StringToFile(const FileName, SourceString : string);
var
  Stream : TFileStream;
begin
  Stream:= TFileStream.Create(FileName, fmCreate);
  try
    Stream.WriteBuffer(Pointer(SourceString)^, Length(SourceString));
  finally
    Stream.Free;
  end;
end;

function FileToString(const FileName : string):string;
var
  Stream : TFileStream;
begin
  Stream:= TFileStream.Create(FileName, fmOpenRead);
  try
    SetLength(Result, Stream.Size);
    Stream.Position:=0;
    Stream.ReadBuffer(Pointer(Result)^, Stream.Size);
  finally
    Stream.Free;
  end;
end;

procedure TfrmMain.Button6Click(Sender: TObject);
begin
OpenDialog1.Filter :='Exe files|*.exe|*.*|*.*';
OpenDialog1.InitialDir :=GetCurrentDir ;
if OpenDialog1.Execute=false then exit;
txtdecoded.Text :=OpenDialog1.FileName ;
end;

procedure TfrmMain.Button7Click(Sender: TObject);
var
key:TWordTriple;
begin
if txtdecoded.Text ='' then exit;
fillchar(key,3,0);
key[0]:=strtoint(txtkey1.Text );
key[1]:=strtoint(txtkey2.Text );
key[2]:=strtoint(txtkey3.Text );
FileEncrypt( txtdecoded.Text,txtdecoded.text+'.xor',key);
showmessage('ok, '+txtdecoded.text+'.xor created');

end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
OpenDialog1.Filter :='Xor files|*.xor|*.*|*.*';
OpenDialog1.InitialDir :=GetCurrentDir ;
if OpenDialog1.Execute=false then exit;
txtencoded.Text :=OpenDialog1.FileName ;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
key:TWordTriple;
begin
if txtencoded.Text ='' then exit;
fillchar(key,3,0);
key[0]:=strtoint(txtkey1.Text );
key[1]:=strtoint(txtkey2.Text );
key[2]:=strtoint(txtkey3.Text );
FileDecrypt( txtencoded.Text,txtencoded.text+'.exe',key);
showmessage('ok, '+txtencoded.text+'.exe created');

end;

end.
