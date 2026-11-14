unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus, Grids, StrUtils, Math;

type
  TEmployeeRecord = record
    ID: Integer;
    FullName: string[100];
    Position: string[50];
    Department: string[50];
    HireDate: TDateTime;
    Salary: Double;
  end;

  TEmployeeList = array of TEmployeeRecord;
  TIntegerArray = array of Integer;

  { TMainForm }

  TMainForm = class(TForm)
    StringGrid1: TStringGrid;
    PanelTop: TPanel;
    LabelID: TLabel;
    EditID: TEdit;
    LabelName: TLabel;
    EditName: TEdit;
    LabelPosition: TLabel;
    EditPosition: TEdit;
    LabelDepartment: TLabel;
    EditDepartment: TEdit;
    LabelHireDate: TLabel;
    EditHireDate: TEdit;
    LabelSalary: TLabel;
    EditSalary: TEdit;
    ButtonAdd: TButton;
    ButtonEdit: TButton;
    ButtonDelete: TButton;
    ButtonClear: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;

    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);

    // Обработчики пунктов меню
    procedure MenuItemNewClick(Sender: TObject);
    procedure MenuItemOpenClick(Sender: TObject);
    procedure MenuItemSaveClick(Sender: TObject);
    procedure MenuItemSaveAsClick(Sender: TObject);
    procedure MenuItemCloseClick(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);
    procedure MenuItemAddClick(Sender: TObject);
    procedure MenuItemEditClick(Sender: TObject);
    procedure MenuItemDeleteClick(Sender: TObject);
    procedure MenuItemSortAscClick(Sender: TObject);
    procedure MenuItemSortDescClick(Sender: TObject);
    procedure MenuItemSearchClick(Sender: TObject);
    procedure MenuItemClearFormClick(Sender: TObject);

  private
    FEmployeeList: TEmployeeList;
    FCurrentFileName: string;
    FModified: Boolean;
    FMainMenu: TMainMenu;
    procedure UpdateGrid;
    procedure ClearInputFields;
    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
    procedure AddRecord(const ARecord: TEmployeeRecord);
    procedure EditRecord(Index: Integer; const ARecord: TEmployeeRecord);
    procedure DeleteRecord(Index: Integer);
    procedure SortRecords(FieldIndex: Integer; Ascending: Boolean);
    function FindRecord(FieldIndex: Integer; const Value: string): TIntegerArray;
    procedure ShowSearchResult(const Indices: TIntegerArray);
    procedure SetModified;
    function CheckModifiedAndSave: Boolean;
    procedure UpdateCaption;
    function ParseDate(const DateStr: string): TDateTime;
    procedure CreateMainMenu;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

function TMainForm.ParseDate(const DateStr: string): TDateTime;
begin
  if not TryStrToDate(DateStr, Result, 'DD.MM.YYYY', '-') then
    raise Exception.Create('Неверный формат даты. Используйте ДД.ММ.ГГГГ');
end;

procedure TMainForm.CreateMainMenu;
var
  miFile, miRecord, miSort: TMenuItem;
  miNew, miOpen, miSave, miSaveAs, miClose, miExit: TMenuItem;
  miAdd, miEdit, miDelete, miSortAsc, miSortDesc, miSearch, miClear: TMenuItem;
  Sep: TMenuItem;
begin
  // Создаём главное меню
  FMainMenu := TMainMenu.Create(Self);
  Self.Menu := FMainMenu;  // ИСПРАВЛЕНО: MainMenu -> Menu

  // ========== Пункт меню "Файл" ==========
  miFile := TMenuItem.Create(FMainMenu);
  miFile.Caption := 'Файл';
  FMainMenu.Items.Add(miFile);

  // Подпункты меню "Файл"
  miNew := TMenuItem.Create(miFile);
  miNew.Caption := 'Создать / Новый файл';
  miNew.OnClick := @MenuItemNewClick;
  miFile.Add(miNew);

  miOpen := TMenuItem.Create(miFile);
  miOpen.Caption := 'Открыть файл';
  miOpen.OnClick := @MenuItemOpenClick;
  miFile.Add(miOpen);

  // Разделитель
  Sep := TMenuItem.Create(miFile);
  Sep.Caption := '-';
  miFile.Add(Sep);

  miSave := TMenuItem.Create(miFile);
  miSave.Caption := 'Сохранить';
  miSave.OnClick := @MenuItemSaveClick;
  miFile.Add(miSave);

  miSaveAs := TMenuItem.Create(miFile);
  miSaveAs.Caption := 'Сохранить как';
  miSaveAs.OnClick := @MenuItemSaveAsClick;
  miFile.Add(miSaveAs);

  // Разделитель
  Sep := TMenuItem.Create(miFile);
  Sep.Caption := '-';
  miFile.Add(Sep);

  miClose := TMenuItem.Create(miFile);
  miClose.Caption := 'Закрыть файл';
  miClose.OnClick := @MenuItemCloseClick;
  miFile.Add(miClose);

  miExit := TMenuItem.Create(miFile);
  miExit.Caption := 'Выход из программы';
  miExit.OnClick := @MenuItemExitClick;
  miFile.Add(miExit);

  // ========== Пункт меню "Запись" ==========
  miRecord := TMenuItem.Create(FMainMenu);
  miRecord.Caption := 'Запись';
  FMainMenu.Items.Add(miRecord);

  // Подпункты меню "Запись"
  miAdd := TMenuItem.Create(miRecord);
  miAdd.Caption := 'Добавить запись';
  miAdd.OnClick := @MenuItemAddClick;
  miRecord.Add(miAdd);

  miEdit := TMenuItem.Create(miRecord);
  miEdit.Caption := 'Редактировать запись';
  miEdit.OnClick := @MenuItemEditClick;
  miRecord.Add(miEdit);

  miDelete := TMenuItem.Create(miRecord);
  miDelete.Caption := 'Удалить запись';
  miDelete.OnClick := @MenuItemDeleteClick;
  miRecord.Add(miDelete);

  // Разделитель
  Sep := TMenuItem.Create(miRecord);
  Sep.Caption := '-';
  miRecord.Add(Sep);

  // Подменю "Сортировка"
  miSort := TMenuItem.Create(miRecord);
  miSort.Caption := 'Сортировка';
  miRecord.Add(miSort);

  miSortAsc := TMenuItem.Create(miSort);
  miSortAsc.Caption := 'по возрастанию';
  miSortAsc.OnClick := @MenuItemSortAscClick;
  miSort.Add(miSortAsc);

  miSortDesc := TMenuItem.Create(miSort);
  miSortDesc.Caption := 'по убыванию';
  miSortDesc.OnClick := @MenuItemSortDescClick;
  miSort.Add(miSortDesc);

  // Разделитель
  Sep := TMenuItem.Create(miRecord);
  Sep.Caption := '-';
  miRecord.Add(Sep);

  miSearch := TMenuItem.Create(miRecord);
  miSearch.Caption := 'Поиск записи';
  miSearch.OnClick := @MenuItemSearchClick;
  miRecord.Add(miSearch);

  miClear := TMenuItem.Create(miRecord);
  miClear.Caption := 'Очистить форму / Новый ввод';
  miClear.OnClick := @MenuItemClearFormClick;
  miRecord.Add(miClear);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Создаём меню программно
  CreateMainMenu;

  // Настройка StringGrid
  StringGrid1.FixedCols := 0;
  StringGrid1.RowCount := 1;
  StringGrid1.ColCount := 6;
  StringGrid1.Cells[0, 0] := 'Таб. №';
  StringGrid1.Cells[1, 0] := 'ФИО';
  StringGrid1.Cells[2, 0] := 'Должность';
  StringGrid1.Cells[3, 0] := 'Отдел';
  StringGrid1.Cells[4, 0] := 'Дата приема';
  StringGrid1.Cells[5, 0] := 'Оклад';
  StringGrid1.ColWidths[0] := 70;
  StringGrid1.ColWidths[1] := 150;
  StringGrid1.ColWidths[2] := 120;
  StringGrid1.ColWidths[3] := 120;
  StringGrid1.ColWidths[4] := 100;
  StringGrid1.ColWidths[5] := 80;
  StringGrid1.Options := StringGrid1.Options + [goRowSelect];

  OpenDialog1.Filter := 'Типизированные файлы (*.dat)|*.dat|Все файлы (*.*)|*.*';
  SaveDialog1.Filter := OpenDialog1.Filter;
  SaveDialog1.DefaultExt := 'dat';

  FCurrentFileName := '';
  FModified := False;
  SetLength(FEmployeeList, 0);
  UpdateGrid;
  UpdateCaption;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CheckModifiedAndSave;
end;

procedure TMainForm.MenuItemNewClick(Sender: TObject);
begin
  if not CheckModifiedAndSave then Exit;
  FCurrentFileName := '';
  SetLength(FEmployeeList, 0);
  FModified := False;
  UpdateGrid;
  ClearInputFields;
  UpdateCaption;
end;

procedure TMainForm.MenuItemOpenClick(Sender: TObject);
begin
  if not CheckModifiedAndSave then Exit;
  if OpenDialog1.Execute then
  begin
    try
      LoadFromFile(OpenDialog1.FileName);
      FCurrentFileName := OpenDialog1.FileName;
      FModified := False;
      UpdateGrid;
      ClearInputFields;
      UpdateCaption;
    except
      on E: Exception do
        ShowMessage('Ошибка при открытии файла: ' + E.Message);
    end;
  end;
end;

procedure TMainForm.MenuItemSaveClick(Sender: TObject);
begin
  if FCurrentFileName = '' then
    MenuItemSaveAsClick(Sender)
  else
  begin
    SaveToFile(FCurrentFileName);
    FModified := False;
    UpdateCaption;
  end;
end;

procedure TMainForm.MenuItemSaveAsClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SaveToFile(SaveDialog1.FileName);
    FCurrentFileName := SaveDialog1.FileName;
    FModified := False;
    UpdateCaption;
  end;
end;

procedure TMainForm.MenuItemCloseClick(Sender: TObject);
begin
  if CheckModifiedAndSave then
  begin
    FCurrentFileName := '';
    SetLength(FEmployeeList, 0);
    FModified := False;
    UpdateGrid;
    ClearInputFields;
    UpdateCaption;
  end;
end;

procedure TMainForm.MenuItemExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.MenuItemAddClick(Sender: TObject);
var
  rec: TEmployeeRecord;
begin
  if (Trim(EditID.Text) = '') or (Trim(EditName.Text) = '') or
     (Trim(EditPosition.Text) = '') or (Trim(EditDepartment.Text) = '') or
     (Trim(EditHireDate.Text) = '') or (Trim(EditSalary.Text) = '') then
  begin
    ShowMessage('Пожалуйста, заполните все поля.');
    Exit;
  end;
  try
    rec.ID := StrToInt(EditID.Text);
    rec.FullName := EditName.Text;
    rec.Position := EditPosition.Text;
    rec.Department := EditDepartment.Text;
    rec.HireDate := ParseDate(EditHireDate.Text);
    rec.Salary := StrToFloat(EditSalary.Text);
    AddRecord(rec);
    SetModified;
    ClearInputFields;
    UpdateGrid;
  except
    on E: EConvertError do
      ShowMessage('Ошибка ввода: проверьте числовые поля (табельный номер и оклад).');
    on E: Exception do
      ShowMessage('Ошибка: ' + E.Message);
  end;
end;

procedure TMainForm.MenuItemEditClick(Sender: TObject);
var
  idx: Integer;
  rec: TEmployeeRecord;
begin
  if StringGrid1.RowCount <= 1 then
  begin
    ShowMessage('Нет записей для редактирования.');
    Exit;
  end;
  if StringGrid1.Row = 0 then
  begin
    ShowMessage('Выберите запись для редактирования.');
    Exit;
  end;
  idx := StringGrid1.Row - 1;
  rec := FEmployeeList[idx];
  EditID.Text := IntToStr(rec.ID);
  EditName.Text := rec.FullName;
  EditPosition.Text := rec.Position;
  EditDepartment.Text := rec.Department;
  EditHireDate.Text := FormatDateTime('DD.MM.YYYY', rec.HireDate);
  EditSalary.Text := FloatToStr(rec.Salary);
  if MessageDlg('Редактирование', 'Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      rec.ID := StrToInt(EditID.Text);
      rec.FullName := EditName.Text;
      rec.Position := EditPosition.Text;
      rec.Department := EditDepartment.Text;
      rec.HireDate := ParseDate(EditHireDate.Text);
      rec.Salary := StrToFloat(EditSalary.Text);
      EditRecord(idx, rec);
      SetModified;
      UpdateGrid;
      ClearInputFields;
    except
      on E: EConvertError do
        ShowMessage('Ошибка ввода: проверьте числовые поля.');
      on E: Exception do
        ShowMessage('Ошибка: ' + E.Message);
    end;
  end;
end;

procedure TMainForm.MenuItemDeleteClick(Sender: TObject);
begin
  if StringGrid1.RowCount <= 1 then
  begin
    ShowMessage('Нет записей для удаления.');
    Exit;
  end;
  if StringGrid1.Row = 0 then
  begin
    ShowMessage('Выберите запись для удаления.');
    Exit;
  end;
  if MessageDlg('Удаление', 'Удалить выбранную запись?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DeleteRecord(StringGrid1.Row - 1);
    SetModified;
    UpdateGrid;
    ClearInputFields;
  end;
end;

procedure TMainForm.MenuItemSortAscClick(Sender: TObject);
var
  Selected: string;
  FieldIdx: Integer;
begin
  Selected := InputBox('Сортировка', 'Выберите поле (0..5):' + sLineBreak +
    '0 - Табельный номер' + sLineBreak +
    '1 - ФИО' + sLineBreak +
    '2 - Должность' + sLineBreak +
    '3 - Отдел' + sLineBreak +
    '4 - Дата приема' + sLineBreak +
    '5 - Оклад', '0');
  if not TryStrToInt(Selected, FieldIdx) or (FieldIdx < 0) or (FieldIdx > 5) then
  begin
    ShowMessage('Неверный номер поля.');
    Exit;
  end;
  SortRecords(FieldIdx, True);
  SetModified;
  UpdateGrid;
end;

procedure TMainForm.MenuItemSortDescClick(Sender: TObject);
var
  Selected: string;
  FieldIdx: Integer;
begin
  Selected := InputBox('Сортировка', 'Выберите поле (0..5):' + sLineBreak +
    '0 - Табельный номер' + sLineBreak +
    '1 - ФИО' + sLineBreak +
    '2 - Должность' + sLineBreak +
    '3 - Отдел' + sLineBreak +
    '4 - Дата приема' + sLineBreak +
    '5 - Оклад', '0');
  if not TryStrToInt(Selected, FieldIdx) or (FieldIdx < 0) or (FieldIdx > 5) then
  begin
    ShowMessage('Неверный номер поля.');
    Exit;
  end;
  SortRecords(FieldIdx, False);
  SetModified;
  UpdateGrid;
end;

procedure TMainForm.MenuItemSearchClick(Sender: TObject);
var
  Selected, SearchValue: string;
  FieldIdx: Integer;
  Indices: TIntegerArray;
begin
  if Length(FEmployeeList) = 0 then
  begin
    ShowMessage('Список пуст. Нечего искать.');
    Exit;
  end;
  Selected := InputBox('Поиск', 'Выберите поле для поиска (0..5):' + sLineBreak +
    '0 - Табельный номер' + sLineBreak +
    '1 - ФИО' + sLineBreak +
    '2 - Должность' + sLineBreak +
    '3 - Отдел' + sLineBreak +
    '4 - Дата приема' + sLineBreak +
    '5 - Оклад', '0');
  if not TryStrToInt(Selected, FieldIdx) or (FieldIdx < 0) or (FieldIdx > 5) then
  begin
    ShowMessage('Неверный номер поля.');
    Exit;
  end;
  SearchValue := InputBox('Поиск', 'Введите значение для поиска:', '');
  if SearchValue = '' then
  begin
    ShowMessage('Значение для поиска не введено.');
    Exit;
  end;
  Indices := FindRecord(FieldIdx, SearchValue);
  ShowSearchResult(Indices);
end;

procedure TMainForm.MenuItemClearFormClick(Sender: TObject);
begin
  ClearInputFields;
end;

procedure TMainForm.ButtonAddClick(Sender: TObject);
begin
  MenuItemAddClick(Sender);
end;

procedure TMainForm.ButtonEditClick(Sender: TObject);
begin
  MenuItemEditClick(Sender);
end;

procedure TMainForm.ButtonDeleteClick(Sender: TObject);
begin
  MenuItemDeleteClick(Sender);
end;

procedure TMainForm.ButtonClearClick(Sender: TObject);
begin
  ClearInputFields;
end;

procedure TMainForm.StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
var
  rec: TEmployeeRecord;
begin
  CanSelect := True;
  if (aRow > 0) and (aRow <= Length(FEmployeeList)) then
  begin
    rec := FEmployeeList[aRow - 1];
    EditID.Text := IntToStr(rec.ID);
    EditName.Text := rec.FullName;
    EditPosition.Text := rec.Position;
    EditDepartment.Text := rec.Department;
    EditHireDate.Text := FormatDateTime('DD.MM.YYYY', rec.HireDate);
    EditSalary.Text := FloatToStr(rec.Salary);
  end;
end;

procedure TMainForm.UpdateGrid;
var
  i: Integer;
begin
  StringGrid1.BeginUpdate;
  try
    StringGrid1.RowCount := Length(FEmployeeList) + 1;
    for i := 0 to High(FEmployeeList) do
    begin
      StringGrid1.Cells[0, i+1] := IntToStr(FEmployeeList[i].ID);
      StringGrid1.Cells[1, i+1] := FEmployeeList[i].FullName;
      StringGrid1.Cells[2, i+1] := FEmployeeList[i].Position;
      StringGrid1.Cells[3, i+1] := FEmployeeList[i].Department;
      StringGrid1.Cells[4, i+1] := FormatDateTime('DD.MM.YYYY', FEmployeeList[i].HireDate);
      StringGrid1.Cells[5, i+1] := FormatFloat('0.00', FEmployeeList[i].Salary);
    end;
  finally
    StringGrid1.EndUpdate;
  end;
end;

procedure TMainForm.ClearInputFields;
begin
  EditID.Text := '';
  EditName.Text := '';
  EditPosition.Text := '';
  EditDepartment.Text := '';
  EditHireDate.Text := '';
  EditSalary.Text := '';
end;

procedure TMainForm.LoadFromFile(const AFileName: string);
var
  F: file of TEmployeeRecord;
  rec: TEmployeeRecord;
  i: Integer;
begin
  if not FileExists(AFileName) then
    raise Exception.Create('Файл не существует.');
  AssignFile(F, AFileName);
  try
    Reset(F);
    SetLength(FEmployeeList, FileSize(F));
    i := 0;
    while not EOF(F) do
    begin
      Read(F, rec);
      if i < Length(FEmployeeList) then
        FEmployeeList[i] := rec;
      Inc(i);
    end;
  finally
    CloseFile(F);
  end;
end;

procedure TMainForm.SaveToFile(const AFileName: string);
var
  F: file of TEmployeeRecord;
  rec: TEmployeeRecord;
begin
  AssignFile(F, AFileName);
  try
    Rewrite(F);
    for rec in FEmployeeList do
      Write(F, rec);
  finally
    CloseFile(F);
  end;
end;

procedure TMainForm.AddRecord(const ARecord: TEmployeeRecord);
begin
  SetLength(FEmployeeList, Length(FEmployeeList) + 1);
  FEmployeeList[High(FEmployeeList)] := ARecord;
end;

procedure TMainForm.EditRecord(Index: Integer; const ARecord: TEmployeeRecord);
begin
  if (Index >= 0) and (Index < Length(FEmployeeList)) then
    FEmployeeList[Index] := ARecord;
end;

procedure TMainForm.DeleteRecord(Index: Integer);
var
  i: Integer;
begin
  if (Index >= 0) and (Index < Length(FEmployeeList)) then
  begin
    for i := Index to Length(FEmployeeList) - 2 do
      FEmployeeList[i] := FEmployeeList[i+1];
    SetLength(FEmployeeList, Length(FEmployeeList) - 1);
  end;
end;

procedure TMainForm.SortRecords(FieldIndex: Integer; Ascending: Boolean);
var
  i, j: Integer;
  tmp: TEmployeeRecord;
  DoSwap: Boolean;
begin
  if Length(FEmployeeList) <= 1 then Exit;
  for i := 0 to Length(FEmployeeList)-2 do
    for j := i+1 to Length(FEmployeeList)-1 do
    begin
      DoSwap := False;
      case FieldIndex of
        0: DoSwap := (Ascending and (FEmployeeList[i].ID > FEmployeeList[j].ID)) or
                     (not Ascending and (FEmployeeList[i].ID < FEmployeeList[j].ID));
        1: DoSwap := (Ascending and (FEmployeeList[i].FullName > FEmployeeList[j].FullName)) or
                     (not Ascending and (FEmployeeList[i].FullName < FEmployeeList[j].FullName));
        2: DoSwap := (Ascending and (FEmployeeList[i].Position > FEmployeeList[j].Position)) or
                     (not Ascending and (FEmployeeList[i].Position < FEmployeeList[j].Position));
        3: DoSwap := (Ascending and (FEmployeeList[i].Department > FEmployeeList[j].Department)) or
                     (not Ascending and (FEmployeeList[i].Department < FEmployeeList[j].Department));
        4: DoSwap := (Ascending and (FEmployeeList[i].HireDate > FEmployeeList[j].HireDate)) or
                     (not Ascending and (FEmployeeList[i].HireDate < FEmployeeList[j].HireDate));
        5: DoSwap := (Ascending and (FEmployeeList[i].Salary > FEmployeeList[j].Salary)) or
                     (not Ascending and (FEmployeeList[i].Salary < FEmployeeList[j].Salary));
      end;
      if DoSwap then
      begin
        tmp := FEmployeeList[i];
        FEmployeeList[i] := FEmployeeList[j];
        FEmployeeList[j] := tmp;
      end;
    end;
end;

function TMainForm.FindRecord(FieldIndex: Integer; const Value: string): TIntegerArray;
var
  Res: TIntegerArray;
  i: Integer;
  Match: Boolean;
begin
  SetLength(Res, 0);
  for i := 0 to High(FEmployeeList) do
  begin
    Match := False;
    case FieldIndex of
      0: Match := IntToStr(FEmployeeList[i].ID) = Value;
      1: Match := AnsiContainsText(FEmployeeList[i].FullName, Value);
      2: Match := AnsiContainsText(FEmployeeList[i].Position, Value);
      3: Match := AnsiContainsText(FEmployeeList[i].Department, Value);
      4: Match := FormatDateTime('DD.MM.YYYY', FEmployeeList[i].HireDate) = Value;
      5: Match := FormatFloat('0.00', FEmployeeList[i].Salary) = Value;
    end;
    if Match then
    begin
      SetLength(Res, Length(Res) + 1);
      Res[High(Res)] := i;
    end;
  end;
  Result := Res;
end;

procedure TMainForm.ShowSearchResult(const Indices: TIntegerArray);
var
  s: string;
  i: Integer;
begin
  if Length(Indices) = 0 then
    ShowMessage('Записи не найдены.')
  else
  begin
    s := 'Найдено записей: ' + IntToStr(Length(Indices)) + sLineBreak;
    for i := 0 to Min(4, High(Indices)) do
      s := s + Format('  %d: %s (%d)', [Indices[i]+1, FEmployeeList[Indices[i]].FullName, FEmployeeList[Indices[i]].ID]) + sLineBreak;
    if Length(Indices) > 5 then s := s + '  ...';
    ShowMessage(s);
    if Length(Indices) > 0 then
      StringGrid1.Row := Indices[0] + 1;
  end;
end;

procedure TMainForm.SetModified;
begin
  FModified := True;
  UpdateCaption;
end;

function TMainForm.CheckModifiedAndSave: Boolean;
var
  resp: Integer;
begin
  Result := True;
  if FModified then
  begin
    resp := MessageDlg('Изменения не сохранены', 'Сохранить изменения?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    case resp of
      mrYes: begin
        if FCurrentFileName = '' then
          MenuItemSaveAsClick(nil)
        else
          SaveToFile(FCurrentFileName);
        FModified := False;
      end;
      mrNo: FModified := False;
      mrCancel: Result := False;
    end;
    UpdateCaption;
  end;
end;

procedure TMainForm.UpdateCaption;
begin
  if FCurrentFileName = '' then
    Caption := 'Сотрудники предприятия - [без имени]' + IfThen(FModified, ' *', '')
  else
    Caption := 'Сотрудники предприятия - ' + ExtractFileName(FCurrentFileName) + IfThen(FModified, ' *', '');
end;

end.
