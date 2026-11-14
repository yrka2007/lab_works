unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn;

type
  { TForm1 }  // <-- Имя формы должно совпадать с тем, что в .lfm
  TForm1 = class(TForm)
    btnCopy: TButton;
    DE: TDirectoryEdit;
    FNE: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnCopyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;  // <-- Переменная формы

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := 'Копирование файла';
  Width := 450;
  Height := 200;
  Position := poDesktopCenter;
  BorderStyle := bsDialog;

  Label1.Caption := 'Выберите файл, который нужно копировать:';
  Label2.Caption := 'Укажите папку, куда копировать файл:';

  FNE.Text := '';
  DE.Text := '';

  btnCopy.Caption := 'Выполнить копирование';
end;

procedure TForm1.btnCopyClick(Sender: TObject);
var
  fIn, fOut: File;
  NumRead, NumWritten: Word;
  Buf: array[1..2048] of byte;
  DestFileName: string;
begin
  if FNE.Text = '' then
  begin
    ShowMessage('Внимание! Требуется указать или выбрать копируемый файл.');
    FNE.SetFocus;
    Exit;
  end;

  if DE.Text = '' then
  begin
    ShowMessage('Внимание! Требуется указать или выбрать папку для копии.');
    DE.SetFocus;
    Exit;
  end;

  if not FileExists(FNE.FileName) then
  begin
    ShowMessage('Внимание! Указанный файл не существует.');
    Exit;
  end;

  DestFileName := DE.Directory + '\' + ExtractFileName(FNE.FileName);

  if FNE.FileName = DestFileName then
  begin
    ShowMessage('Внимание! Нельзя скопировать файл сам в себя.');
    Exit;
  end;

  try
    AssignFile(fIn, FNE.FileName);
    AssignFile(fOut, DestFileName);

    Reset(fIn, 1);
    Rewrite(fOut, 1);

    Screen.Cursor := crHourGlass;

    repeat
      BlockRead(fIn, Buf, SizeOf(Buf), NumRead);
      if NumRead > 0 then
        BlockWrite(fOut, Buf, NumRead, NumWritten);
    until (NumRead = 0);

    ShowMessage('Копирование завершено!');

  finally
    CloseFile(fIn);
    CloseFile(fOut);
    Screen.Cursor := crDefault;
  end;
end;

end.
