unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  procedure OnMessage(var Msg: TMsg; var Handled: Boolean);
  procedure OnIdle(Sender: TObject; var Done: Boolean);
  procedure Draw(Canvas: TCanvas; var r, g, b: integer;
width, height: integer);
  end;

var
  Form1: TForm1;
   r, g, b: integer;
  po: TPoint;
  IniFileName: string;


implementation

{$R *.dfm}
uses
  IniFiles;

procedure TForm1.Draw(Canvas: TCanvas; var r, g, b: integer;
width, height: integer);
begin
  with Canvas do
  begin
    r := r + random(3) - 1;
    if r < 0 then
      r := 0;
    if r > 255 then
      r := 255;
    g := g + random(3) - 1;
    if g < 0 then
      g := 0;
    if g > 255 then
      g := 255;
    b := b + random(3) - 1;
    if b < 0 then
      b := 0;
    if b > 255 then
      b := 255;

    Pen.Color := RGB(r, g, b);
    LineTo(random(width), random(height));
  end;
end;

procedure TForm1.OnMessage(var Msg: TMsg; var Handled: Boolean);
begin
  case Msg.message of
    WM_KEYDOWN, WM_KEYUP,
    WM_SYSKEYDOWN, WM_SYSKEYUP,
    WM_LBUTTONDOWN, WM_RBUTTONDOWN,
    WM_MBUTTONDOWN: Close;
    WM_MOUSEMOVE:
    begin
      if (msg.pt.x <> po.x) or (msg.pt.y <> po.y) then
        Close;
    end;
  end;
end;

procedure TForm1.OnIdle(Sender: TObject; var Done: Boolean);
begin
  Draw(Canvas, r, g, b, Width, Height);
  Done := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ini: TIniFile;
begin
  Application.OnMessage := OnMessage;
  Application.OnIdle := OnIdle;

  {??? ??? ???????? ????? ?????????? ??? ?????? Object Inspector}
  BorderStyle := bsNone;
  WindowState := wsMaximized;

  ShowCursor(false);
  GetCursorPos(po);

  ini := TIniFile.Create(IniFileName);
  if ini.ReadBool('settings', 'clear', true) then
    Brush.Color := clBlack
  else
    Brush.Style := bsClear;
  ini.Destroy;
end;
end.
