unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
uses
  IniFiles, UMain;


procedure TForm2.FormCreate(Sender: TObject);
var
  buf: array [0..127] of char;
  ini: TIniFile;
begin
  GetWindowsDirectory(buf, sizeof(buf));
  if pos(UpperCase(buf), UpperCase(ExtractFilePath(ParamStr(0)))) <= 0 then
    if not CopyFile(PChar(ParamStr(0)), PChar(buf + '\MyScrSaver.scr'), false) then
      ShowMessage('Can not copy the file');
  ini := TIniFile.Create(IniFileName);
  CheckBox1.Checked := ini.ReadBool('settings', 'clear', true);
  ini.Destroy;

  {��� ��� �������� ����� ���������� ��� ������ Object Inspector}
  Button1.Caption := 'OK';
  Button2.Caption := 'Cancel';
  CheckBox1.Caption := 'Clear screen';
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(IniFileName);
  ini.WriteBool('settings', 'clear', CheckBox1.Checked);
  ini.Destroy;
  Close;
end;



procedure TForm2.Button2Click(Sender: TObject);
begin
  Close;
end;


end.
