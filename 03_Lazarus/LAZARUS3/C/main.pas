unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Calendar, EditBtn;

type

  { TForm1 }

  TForm1 = class(TForm)
    Calendar1: TCalendar;
    DateEdit1: TDateEdit;
    procedure Calendar1Change(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure DateEdit1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Calendar1Change(Sender: TObject);
begin

end;

procedure TForm1.DateEdit1Change(Sender: TObject);
begin

end;

procedure TForm1.DateEdit1Click(Sender: TObject);
begin

end;

end.

